class Forum2Discourse::Models::SMF::User
  include DataMapper::Resource

  storage_names[:default] = "smf_members"

  property :id, Serial, field: "ID_MEMBER"
  property :username, String, field: "memberName"
  property :email,      String, field: "emailAddress"
  property :realName,  String, field: "realName"
  property :created_at, EpochTime, field: "dateRegistered"

  def to_discourse
    Forum2Discourse::Models::Discourse::User.new(
      username: username,
      email: email,
      name: realName,
      created_at: created_at
    )
  end
end
