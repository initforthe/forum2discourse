require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-mysql-adapter'

module Forum2Discourse
  class Exporter

    # Store a registry of exporters
    def self.registry
      @registry ||= {}
    end

    def self.register(type, format)
      registry[type] = format
    end

    def self.registered?(type)
      registry.has_key? type
    end

    def self.create(type, options)
      registry[type].new(options)
    end

    def initialize(type, options)
      setup_database(options.delete(:connection_string))
      @exporter = self.class.create(type, options)
      self
    end

    def perform
      @exporter.perform
    end

    private

    def setup_database(connection_string)
      DataMapper::Logger.new($stdout, :debug)
      DataMapper.setup(:default, connection_string)
    end
  end
end
