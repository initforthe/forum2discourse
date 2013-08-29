class Forum2Discourse::Models::SMF::Board
  include DataMapper::Resource

  storage_names[:default] = 'smf_boards'

  property :id,           Serial, field: 'ID_BOARD'
  property :category_id,  Integer, field: 'ID_CAT'
  property :subject,      Text, field: 'name'
  property :description   Text, field: 'description'

  has n, :topics, 'Forum2Discourse::Models::SMF::Topic'
  belongs_to :category, 'Forum2Discourse::Models::SMF::Category'

end
