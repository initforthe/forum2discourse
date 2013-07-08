require 'spec_helper'
require 'forum2discourse'
require 'forum2discourse/importer'

describe Forum2Discourse::Importer do
  before do
    require 'ostruct'
    SiteSetting = OpenStruct.new if !defined? SiteSetting
    ENV['F2C_LOG_LEVEL'] = '0'
    if !defined? RateLimiter
      class RateLimiter; end
    end
  end

  describe "#import" do
    let(:importer) { Forum2Discourse::Importer.new([]) }

    it 'resets settings to what they were before an import, after an import' do
      SiteSetting.min_topic_title_length = "TEST"
      importer.import
      expect(SiteSetting.min_topic_title_length).to eq("TEST")
    end

    it 'calls import_topic for each topic in the collection' do
      pending
    end
  end

  describe "#import_topic" do
    it "creates a TopicCreator with the correct options" do
      pending
    end
    it "calls import_topic_posts to import the posts for the topic" do
      pending
    end
  end

  describe "#find_or_create_category" do
    it "returns a category that already exists" do
      pending
    end

    it "creates a category if it does not already exist" do
      pending
    end
  end

  describe "#import_topic_posts" do
    it "calls PostCreator for each post" do
      pending
    end
  end
end
