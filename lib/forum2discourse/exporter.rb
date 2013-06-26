module Forum2Discourse
  class Exporter

    # Store a registry of exporters
    @registry = {}

    def self.register(type, format)
      @registry[type] = format
    end

    def initialize(type, options)
      setup_database(options.delete(:connection_string))
      @exporter = @registry[type].new(options)
    end

    def perform
      @exporter.perform
    end

    private

    def setup_database(connection_string)
      DataMapper::Logger.new($stdout, :debug)
      DataMapper.setup(:default, options[:connection_string])
    end
  end
end
