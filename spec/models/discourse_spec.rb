require 'spec_helper'
require 'forum2discourse'

describe Forum2Discourse::Models::Discourse do
  context "User" do
    it "passes validation with all fields" do
      u = Forum2Discourse::Models::Discourse::User.new(username: 'test', email: 'test@example.com')
      expect(u.valid?).to be(true)
    end

    it "fails validation without a username" do
      u = Forum2Discourse::Models::Discourse::User.new(username: nil, email: 'test@example.com')
      expect(u.valid?).to be(false)
    end

    it "fails validation without an email" do
      u = Forum2Discourse::Models::Discourse::User.new(username: 'test', email: nil)
      expect(u.valid?).to be(false)
    end

    it "fails validation with an empty email" do
      u = Forum2Discourse::Models::Discourse::User.new(username: 'test', email: '')
      expect(u.valid?).to be(false)
    end

    it "fails validation with an empty username" do
      u = Forum2Discourse::Models::Discourse::User.new(username: '', email: 'test@example.com')
      expect(u.valid?).to be(false)
    end
  end

  context "Topic" do
    let(:post) { Forum2Discourse::Models::Discourse::Post.new({}) }

    it "passes validation with all fields" do
      t = Forum2Discourse::Models::Discourse::Topic.new(
        title: 'Test title',
        posts: [post]
      )
      expect(t.valid?).to be(true)
    end

    it "fails validation with no posts" do
      t = Forum2Discourse::Models::Discourse::Topic.new(
        title: 'Test title',
        posts: []
      )
      expect(t.valid?).to be(false)
    end

    it "fails validation with no title" do
      t = Forum2Discourse::Models::Discourse::Topic.new(
        title: nil,
        posts: [post]
      )
      expect(t.valid?).to be(false)
    end

    it "fails validation with empty title" do
      t = Forum2Discourse::Models::Discourse::Topic.new(
        title: '',
        posts: [post]
      )
      expect(t.valid?).to be(false)
    end
  end
end
