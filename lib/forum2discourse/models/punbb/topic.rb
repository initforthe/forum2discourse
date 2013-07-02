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

  has n, :posts, 'Forum2Discourse::Models::PunBB::Post'
  belongs_to :forum, 'Forum2Discourse::Models::PunBB::Forum'

  def to_discourse
    # Break early if the forum this post should be in does not exist anymore
    return nil if forum.nil?
    Forum2Discourse::Models::Discourse::Topic.new({
      title: subject,
      created_at: posted,
      category: forum.forum_name,
      posts: posts.map(&:to_discourse)
    })
  end
end
