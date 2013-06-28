module Forum2Discourse::Exporters
  class PunBB
    Forum2Discourse::Exporter.register(:punbb, self)

    def initialize(options)
      self
    end
  end
end
