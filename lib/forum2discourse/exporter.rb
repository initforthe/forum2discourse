require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-mysql-adapter'

module Forum2Discourse
  class Exporter

    # Store a registry of exporters
    def self.registry
      @registry ||= {}
    end

    def self.clear_registry
      @registry = {}
    end

    def self.register(type, format)
      registry[type] = format
    end

    def self.registered?(type)
      registry.has_key? type
    end

    def self.create(type, options)
      setup_database(options.delete(:connection_string))
      registry[type].new(options)
    end

    private

    def self.setup_database(connection_string)
      DataMapper::Logger.new($stdout, :debug)
      DataMapper.setup(:default, connection_string)
    end
  end
end
