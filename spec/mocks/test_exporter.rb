class TestExporter
  Forum2Discourse::Exporter.register(:test, self)
  def initialize(options)
    self
  end

  def perform
  end
end
