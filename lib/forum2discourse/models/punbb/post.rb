class Forum2Discourse::Models::PunBB::Post
  include DataMapper::Resource

  storage_names[:default] = "posts"

  property :id,         Serial
  property :poster,     String
  property :poster_id,  Integer
  property :poster_email, String
  property :message,    Text
  property :posted,     EpochTime
  property :topic_id,   Integer

  belongs_to :topic, 'Forum2Discourse::Models::PunBB::Topic'
  belongs_to :poster, 'Forum2Discourse::Models::PunBB::User'

  def to_discourse
    Forum2Discourse::Models::Discourse::Post.new({
      title: '',
      category: topic.forum.forum_name,
      user: poster.to_discourse,
      raw: message,
      created_at: posted
    })
  end
end
