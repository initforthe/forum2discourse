require 'forum2discourse/importer'

namespace :forum2discourse do
  desc "Import from PunBB to Discourse Posts and Topics"
  task :import_punbb => :environment do
    if ENV['F2D_CONNECTION_STRING'].blank?
      puts "You must specify a connection string"
      puts " i.e.: export F2D_CONNECTION_STRING=mysql://root@host-ip:3308/database"
      exit
    end
    # 'mysql://root@127.0.0.1:3306/bytemark_punbb
    exporter = Forum2Discourse::Exporter.create(:punbb, connection_string: ENV['F2D_CONNECTION_STRING'])
    puts "Importing #{exporter.topics.size} topics"
    Forum2Discourse::Importer.new(exporter.topics).import
  end
end

def import_topics(topics)
  found_categories = []
  topics.each do |topic|
    # Skip topics without a title
    next if topic.title.blank?
    # Skip topics without a post
    next if topic.posts.first.nil?
    puts "Importing '#{topic.title}'"
    u = User.create_with(user_data.serialize).find_or_create_by_username(user_data.serialize[:username])
    g = Guardian.new(u)
    unless found_categories.include? topic.category
      Category.find_or_create_by_name(topic.category) do |c| # Create category if not exists first.
        c.user = u
      end
      found_categories << topic.category
    end
    discourse_topic = TopicCreator.new(u, g, topic.serialize).create
    import_topic_posts(discourse_topic, topic.posts)
  end
end

def import_topic_posts(discourse_topic, posts)
  posts.each do |post|
    user = User.create_with(post.user.serialize).find_or_create_by_username(post.user.serialize[:username])
    data = post.serialize.merge({topic_id: discourse_topic.id})
    PostCreator.new(user, data).create
  end
  puts "  Imported #{posts.size} posts"
end

