class Forum2Discourse::Models::Discourse::Upload < Forum2Discourse::Models::Discourse::Base
  # Standard attrs
  attr_accessor :original_filename, :filesize, :width, :height, :url, :sha1

  # User attrs
  attr_accessor :user_id

  # Time attrs
  attr_accessor :created_at, :updated_at


  def initialize(attrs)
    super
  end

  def valid?
    !original_filename.nil? &&
      !original_filename.empty?
  end

  def serialize
    super.tap { |s| }
  end
end
