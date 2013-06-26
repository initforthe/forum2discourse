module Forum2Discourse::Exporters
  class PunBB
    Forum2Discourse::Exporter.register(:punbb, self)

    def initialize(options)
      self
    end

    def perform
      puts "The magic is happening for #{self.inspect}!"
    end
  end
end
