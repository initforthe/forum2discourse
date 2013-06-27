require 'spec_helper'
require 'forum2discourse/exporter'

describe Forum2Discourse::Exporter do
  describe "registry" do
    it 'has no registered types when first loaded' do
      Forum2Discourse::Exporter.registry.size.should eq(0)
    end

    context 'when punbb is loaded' do
      before do
        require 'forum2discourse/exporters/punbb'
      end

      it 'has one registered type when punbb is loaded' do
        Forum2Discourse::Exporter.registry.size.should eq(1) 
      end

      it 'shows punbb as registered' do
        Forum2Discourse::Exporter.registered?(:punbb).should be_true
      end
    end
  end
end
