class Forum2Discourse::Models::PunBB::Topic
  include DataMapper::Resource

  storage_names[:default] = "topics"

  property :id,           Serial
  property :poster,       String
  property :subject,      Text
  property :posted,       EpochTime
  property :last_post,    EpochTime
  property :last_post_id, Integer
  property :last_poster,  String
  property :num_views,    Integer
  property :num_replies,  Integer
  property :closed,       Boolean
  property :sticky,       Boolean
  property :moved_to,     Integer
  property :forum_id,     Integer

  def to_discourse
    Forum2Discourse::Models::Discourse::Topic.new
  end
end
