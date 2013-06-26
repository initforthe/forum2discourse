module Forum2Discourse
  class Exporter

    # Store a registry of exporters
    @registry = {}

    def self.register(type, format)
      @registry[type] = format
    end

    def initialize(type, options)
      setup_database(options.delete(:database))
      @exporter = @registry[type].new(options)
    end

    def perform
      @exporter.perform
    end

    private

    def setup_database

    end
  end
end
