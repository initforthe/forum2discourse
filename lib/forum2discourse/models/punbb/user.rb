class Forum2Discourse::Models::PunBB::User
  include DataMapper::Resource

  storage_names[:default] = "users"

  property :id,       Serial
  property :username, String
  property :email,    String
  property :password, String
  property :title,    String
  property :realname, String
  property :signature,  Text

  def to_discourse
    Forum2Discourse::Models::Discourse::User.new({
      username: username,
      email: email,
      name: realname
    })
  end
end
