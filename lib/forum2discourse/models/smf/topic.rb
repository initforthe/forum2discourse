class Forum2Discourse::Models::SMF::Topic
  include DataMapper::Resource

  storage_names[:default] = "smf_topics"

  property :id,   Integer, field: 'ID_TOPIC'
  property :board_id, Integer, field: 'ID_BOARD'
  property :views,  Integer,    field: 'numViews'
  #property :user_id, Integer, field: 'ID_MEMBER_STARTED'

  has n, :messages, 'Forum2Discourse::Models::SMF::Message'
  belongs_to :board, 'Forum2Discourse::Models::SMF::Board'
  #belongs_to :user, 'Forum2Discourse::Models::SMF::User'

  def to_discourse
    return nil if board == nil?
    subject = messages.first==nil ? "" : messages.first.subject
    first_post_created_at = messages.first==nil ? nil : messages.first.created_at
    last_post_created_at = messages.last==nil ? nil : messages.last.created_at
    Forum2Discourse::Models::Discourse::Topic.new({
      category: board.subject,
      posts: messages.map(&:to_discourse),
      title: subject,
      created_at: first_post_created_at,
      updated_at: last_post_created_at,
      views: views
    })
  end
end
