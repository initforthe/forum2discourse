class Forum2Discourse::Models::SMF::Topic
  include DataMapper::Resource

  storage_names[:default] = "smf_topics"

  property :id,   Serial, field: 'ID_TOPIC'
  property :board_id, Integer, field: 'ID_BOARD'
  #property :user_id, Integer, field: 'ID_MEMBER_STARTED'

  has n, :messages, 'Forum2Discourse::Models::SMF::Message'
  belongs_to :board, 'Forum2Discourse::Models::SMF::Board'
  #belongs_to :user, 'Forum2Discourse::Models::SMF::User'

  def to_discourse
    return nil if board == nil?
    subject = messages.first==nil ? "" : messages.first.subject
    Forum2Discourse::Models::Discourse::Topic.new({
      category: board.subject,
      posts: messages.map(&:to_discourse),
      title: subject
    })
  end
end
