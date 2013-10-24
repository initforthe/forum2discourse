class Forum2Discourse::Models::Discourse::Post < Forum2Discourse::Models::Discourse::Base
  # Standard attrs
  attr_accessor :title, :category, :raw, :created_at #, :topic_id
  # Relationships
  attr_accessor :user
  # Weird attrs
  attr_accessor :meta_data, :archetype
  
  belongs_to :topic, 'Forum2Discourse::Models::Discourse::Topic'

  def serialize
    super.tap { |s| s.delete(:user) }
  end
end
