class Forum2Discourse::Models::PunBB::Forum
  include DataMapper::Resource

  storage_names[:default] = "forums"

  property :id,         Serial
  property :forum_name, String
  property :forum_desc, String
end
