require 'forum2discourse/models/vanilla'

module Forum2Discourse::Exporters
  class Vanilla
    Forum2Discourse::Exporter.register(:vanilla, self)

    def initialize(options)
      self
    end

    def topics(args={})
      @topics ||= convert(Forum2Discourse::Models::Vanilla::Discussion.all(args))
    end

    private

    def convert(collection)
      collection.map(&:to_discourse).compact
    end
  end
end
