require 'forum2discourse/models/punbb'

# Each exporter should return a collection of
# Forum2Discourse::Discourse::Topic, each of which have many
# Forum2Discourse::Discourse::Post associated with them. Each topic and post
# should be associated with a Forum2Discourse::Discourse::User

module Forum2Discourse::Exporters
  class PunBB
    Forum2Discourse::Exporter.register(:punbb, self)

    def initialize(options)
      self
    end

    def topics(args={})
      convert(Forum2Discourse::Models::PunBB::Topic.all(args))
    end

    private

    def convert(collection)
      collection.map(&:to_discourse)
    end
  end
end
