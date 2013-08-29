class Forum2Discourse::Models::SMF::Category
  include DataMapper::Resource

  storage_names[:default] = "smf_categories"

  property :id, Serial, field: 'ID_CAT'
  property :name, String, field: 'name'
end
