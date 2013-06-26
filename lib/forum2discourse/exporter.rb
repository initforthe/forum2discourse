module Forum2Discourse
  class Exporter

    # Store a registry of exporters
    @registry = {}

    def self.register(type, format)
      @registry[type] = format
    end

    def initialize(type, options)
      @exporter = @registry[type].new(options)
    end

    def perform
      @exporter.perform
    end

  end
end
