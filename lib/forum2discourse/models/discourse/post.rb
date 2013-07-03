class Forum2Discourse::Models::Discourse::Post < Forum2Discourse::Models::Discourse::Base
  # Standard attrs
  attr_accessor :title, :category, :topic_id, :raw, :created_at
  # Relationships
  attr_accessor :user
  # Weird attrs
  attr_accessor :meta_data, :archetype

  def serialize
    super.tap { |s| s.delete(:user) }
  end
end
