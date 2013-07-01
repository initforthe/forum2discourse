class Forum2Discourse::Models::Discourse::Base
  def initialize(attrs)
    @attrs = []
    attrs.each do |key, value|
      send("#{key}=", value)
      @attrs << key
    end
  end

  def serialize
    {}.tap do |output|
      @attrs.each { |key| output[key] = send(key) }
    end
  end
end
