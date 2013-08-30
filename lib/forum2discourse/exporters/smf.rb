require 'forum2discourse/models/smf'

module Forum2Discourse::Exporters
  class SMF
    Forum2Discourse::Exporter.register(:smf, self)

    def initialize(options)
      self
    end

    def topics(args={})
      @topics ||= convert(Forum2Discourse::Models::SMF::Topic.all(args))
    end

    private

    def convert(collection)
      collection.map(&:to_discourse).compact
    end
    
    def firstTopic(args={})
        Forum2Discourse::Models::SMF::Topic.first
    end
  end
end
