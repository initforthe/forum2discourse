require 'spec_helper'
require 'forum2discourse/exporter'
require 'forum2discourse/exporters/punbb'

describe Forum2Discourse::Exporters::PunBB do
  before do
    # Set up test database
  end

  describe "#categories" do
    it 'exports the correct categories' do
      pending('test database not implemented yet')
    end
  end
end
