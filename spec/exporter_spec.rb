require 'spec_helper'
require 'forum2discourse/exporter'

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

  describe '#database_setup' do
    # Stub DataMapper.setup
    # initialize new Exporter with args
    # Expect datamapper to recieve setup with args of database
  end
end
