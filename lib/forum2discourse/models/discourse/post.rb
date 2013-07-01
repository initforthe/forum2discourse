class Forum2Discourse::Models::Discourse::Post < Forum2Discourse::Models::Discourse::Base
  # Standard attrs
  attr_accessor :title, :category, :topic_id, :raw, :created_at
  # Weird attrs
  attr_accessor :meta_data, :archetype
end
