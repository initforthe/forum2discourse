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
    
    def firstTopic(args={})
        Forum2Discourse::Models::SMF::Topic.first
    end
    
    def topicsSlice(offset,chunk)
        Forum2Discourse::Models::SMF::Topic.slice(offset,chunk)
    end

    private

    def convert(collection)
      collection.map(&:to_discourse).compact
    end
  end
end
