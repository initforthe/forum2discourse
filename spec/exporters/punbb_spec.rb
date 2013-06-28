require 'spec_helper'
require 'test_database'
require 'forum2discourse/exporter'
require 'forum2discourse/exporters/punbb'
require 'pry'

describe Forum2Discourse::Exporters::PunBB do
  before do
    TestDatabase.prepare
    # Ensure punbb is included in registry as prior tests could have removed it
    Forum2Discourse::Exporter.clear_registry
    Forum2Discourse::Exporter.register(:punbb, Forum2Discourse::Exporters::PunBB)
  end

  let(:exporter) { Forum2Discourse::Exporter.create(:punbb, connection_string: 'mysql://root@127.0.0.1:3306/forum2discourse_test') }

  describe "#topics" do
    it 'returns an Array of Forum2Discourse::Models::Discourse::Topic' do
      expect(exporter.topics).to be_kind_of(Array)
      exporter.topics.should each do |item|
        expect(item).to be_kind_of(Forum2Discourse::Models::Discourse::Topic)
      end
    end

    it 'returns the correct number of topics' do
      pending 'No test database yet'
    end
  end
end
