class Forum2Discourse::Models::Vanilla::Comment
  include DataMapper::Resource

  storage_names[:default] = "LUM_Comment"

  property :id,   Serial, field: 'CommentID'
  property :created_at, DateTime, field: 'DateCreated'
  property :discussion_id, Integer, field: 'DiscussionID'
  property :user_id, Integer, field: 'AuthUserID'
  property :body, Text, field: 'Body'

  belongs_to :discussion, 'Forum2Discourse::Models::Vanilla::Discussion'
  belongs_to :user, 'Forum2Discourse::Models::Vanilla::User'

  def to_discourse
    duser = user.nil? ? Forum2Discourse::Models::Discourse::User.anonymous : user.to_discourse
    Forum2Discourse::Models::Discourse::Post.new(
      title: '',
      category: discussion.category.name,
      user: duser,
      raw: body,
      created_at: created_at
    )
  end
end
