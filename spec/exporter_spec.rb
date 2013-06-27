require 'spec_helper'
require 'forum2discourse/exporter'

describe Forum2Discourse::Exporter do
  describe "registry" do
    it 'has no registered types when first loaded' do
      Forum2Discourse::Exporter.registry.size.should eq(0)
    end

    context 'when an exporter is loaded' do
      before do
        require 'mocks/test_exporter'
      end

      it 'has one registered type' do
        Forum2Discourse::Exporter.registry.size.should eq(1) 
      end

      it 'shows test as registered' do
        Forum2Discourse::Exporter.registered?(:test).should be_true
      end

      it 'does not show fake as registered' do
        Forum2Discourse::Exporter.registered?(:fake).should be_false
      end
    end
  end

  describe 'database_setup' do
    # Stub DataMapper.setup
    # initialize new Exporter with args
    # Expect datamapper to recieve setup with args of database
  end
end
