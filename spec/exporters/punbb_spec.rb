require 'spec_helper'
require 'test_database'
require 'forum2discourse/exporter'
require 'forum2discourse/exporters/punbb'

describe Forum2Discourse::Exporters::PunBB do
  before do
    TestDatabase.prepare
  end

  describe "#categories" do
    let(:exporter) { Forum2Discourse::Exporter.new(:punbb, connection_string: 'mysql://root@127.0.0.1:3306/forum2discourse_test') }
    let(:expected_output) do
      {
        fields: ['']
      }
    end
    it 'exports forums as categories' do
      expet(exporter.perform).to be(expected_output)
    end
  end
end
