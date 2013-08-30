require 'htmlentities'
class Forum2Discourse::Models::SMF::Message
  include DataMapper::Resource

  storage_names[:default] = "smf_messages"

  property :id,   Serial, field: 'ID_MSG'
  property :created_at, EpochTime, field: 'posterTime'
  property :topic_id, Integer, field: 'ID_TOPIC'
  #property :board_id, Integer, field: 'ID_BOARD'
  property :user_id, Integer, field: 'ID_MEMBER'
  property :body, Text, field: 'body'
  property :subject, Text, field: 'subject'

  belongs_to :topic, 'Forum2Discourse::Models::SMF::Topic'
  #belongs_to :board, 'Forum2Discourse::Models::SMF::Board'
  belongs_to :user, 'Forum2Discourse::Models::SMF::User'

  def to_discourse
    return nil if topic==nil or topic.board==nil or topic.board.category==nil?
    duser = user.nil? ? Forum2Discourse::Models::Discourse::User.anonymous : user.to_discourse
    Forum2Discourse::Models::Discourse::Post.new(
      title: subject,
      category: topic.board.subject,
      user: duser,
      raw: HTMLEntities.new.decode(body).gsub("[code]","\n````\n").gsub("[/code]","\n````\n").gsub("<br/>","").gsub("<br />",""),
      created_at: created_at
    )
  end
end
