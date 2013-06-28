require 'spec_helper'
require 'forum2discourse'

describe Forum2Discourse::Exporter do
  before(:each) do
    Forum2Discourse::Exporter.clear_registry
  end

  describe "#registry" do
    it 'has no registered types when first loaded' do
      expect(Forum2Discourse::Exporter.registry).to be_empty
    end

    it 'has 1 registered type when a type is registered' do
      Forum2Discourse::Exporter.register(:test, Object.new)
      expect(Forum2Discourse::Exporter.registry).to have(1).item
    end
  end

  describe "#registered?" do
    context 'without an exporter loaded' do
      it 'shows test as unregistered' do
        expect(Forum2Discourse::Exporter.registered?(:test)).to be_false
      end
    end

    context 'when an exporter is loaded' do
      before do
        Forum2Discourse::Exporter.register(:test, Object.new)
      end

      it 'shows test as registered' do
        expect(Forum2Discourse::Exporter.registered?(:test)).to be_true
      end

      it 'does not show fake as registered' do
        expect(Forum2Discourse::Exporter.registered?(:fake)).to be_false
      end
    end
  end

  describe '#new' do
    # Stub DataMapper.setup
    # initialize new Exporter with args
    # Expect datamapper to recieve setup with args of database
    before do
      class MyExporter
        def initialize(options); end
      end
      Forum2Discourse::Exporter.register(:test, MyExporter)
    end

    it 'connects to the provided database' do
      DataMapper.should_receive(:setup).with(:default, 'mysql://root@localhost/database')
      Forum2Discourse::Exporter.create(:test, connection_string: 'mysql://root@localhost/database')
    end

    it 'creates the correct exporter' do
      MyExporter.should_receive(:new)
      Forum2Discourse::Exporter.create(:test, connection_string: 'mysql://root@localhost/database')
    end
  end
end
