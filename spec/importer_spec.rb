require 'spec_helper'
require 'forum2discourse'
require 'forum2discourse/importer'

# This spec is a little convoluted, because we need to stub away/mock
# everything that requires the rails environment to complete -- activerecord
# models and discourse functionality, for example.

describe Forum2Discourse::Importer do
  before do
    require 'ostruct'
    SiteSetting = OpenStruct.new if !defined? SiteSetting
    ENV['F2C_LOG_LEVEL'] = '0'
    # Discourse class stubbing
    class TopicCreator; def initialize(u,g,t); self; end; end unless defined? TopicCreator
    class RateLimiter; end unless defined? RateLimiter
    class User; end unless defined? User
    class Guardian; def initialize(user); @user = user; end; end unless defined? Guardian
    class Category; end unless defined? Category
  end

  let(:user) { Forum2Discourse::Models::Discourse::User.anonymous }

  let(:post) do
    Forum2Discourse::Models::Discourse::Post.new(
      raw: 'A test post',
      user: user
    )
  end

  let(:topic) do
    Forum2Discourse::Models::Discourse::Topic.new(
      title: 'A test discourse topic',
      category: 'Test category',
      user_id: 1,
      posts: [post]
    )
  end

  describe "#import" do
    before do
      importer.stub(:import_topic) { true }
    end

    let(:importer) { Forum2Discourse::Importer.new([topic]) }

    it 'resets settings to what they were before an import, after an import' do
      SiteSetting.min_topic_title_length = "TEST"
      importer.import
      expect(SiteSetting.min_topic_title_length).to eq("TEST")
    end

    it 'calls import_topic for each topic in the collection' do
      importer.should_receive(:import_topic).with(topic)
      importer.import
    end
  end

  describe "#import_topic" do
    before do
      class FakeARObject
        def persisted?; true; end
      end
      # Stub the various AR methods used internally by the importer
      User.stub(:create_with).and_return(User)
      User.stub(:find_or_create_by_username).and_return(FakeARObject.new)
      Category.stub(:create_with).and_return(Category)
      Category.stub(:find_or_create_by_name).and_return(FakeARObject.new)
    end
    let(:importer) { Forum2Discourse::Importer.new([topic]) }
    let(:guardian) { Guardian.new(user) }

    it "creates a TopicCreator with the correct options" do
      # Make sure guardian is 'singleton-esque'
      Guardian.stub(:new).and_return(guardian)
      # Stub away methods we don't care about, we're only testing TopicCreator
      # recieves the correct options for a post here.
      TopicCreator.any_instance.stub(:create)
      Forum2Discourse::Importer.any_instance.stub(:import_topic_posts).and_return(:true)
      # Check TopicCreator receives the correct arguments.
      TopicCreator.should_receive(:new).with(user, guardian, topic.serialize).and_call_original
      # Now trigger off our import
      importer.import
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
