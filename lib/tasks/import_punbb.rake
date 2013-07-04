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
    # Override some settings to permit import
    originals = set_original_settings
    import_topics(exporter.topics)
    reset_settings_to(originals)
  end
end

def import_topics(topics)
  found_categories = []
  topics.each do |topic|
    next if topic.title.blank?
    puts "Importing '#{topic.title}'"
    user_data = topic.posts.first.user
    u = User.create_with(user_data.serialize).find_or_create_by_username(user_data.username)
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
    user = User.create_with(post.user.serialize).find_or_create_by_username(post.user.username)
    data = post.serialize.merge({topic_id: discourse_topic.id})
    PostCreator.new(user, data).create
  end
  puts "  Imported #{posts.size} posts"
end

def set_original_settings
  {
    max_word_length: SiteSetting.max_word_length,
    title_min_entropy: SiteSetting.title_min_entropy,
    min_topic_title_length: SiteSetting.min_topic_title_length,
    allow_duplicate_topic_titles: SiteSetting.allow_duplicate_topic_titles?
  }.tap do |_|
    perform_monkey_patching
    SiteSetting.min_topic_title_length = 1
    SiteSetting.title_min_entropy = 0
    SiteSetting.max_word_length = 65535
    SiteSetting.allow_duplicate_topic_titles = true
  end
end

# Certain settings we need to override for the importer are hardcoded.
def perform_monkey_patching
  class << User
    def self.username_length; 3..65535; end
  end
  class << RateLimiter
    def disabled?; true; end
  end
end

def reset_settings_to(originals)
  SiteSetting.max_word_length = originals[:max_word_length]
  SiteSetting.min_topic_title_length = originals[:min_topic_title_length]
  SiteSetting.title_min_entropy = originals[:title_min_entropy]
  SiteSetting.allow_duplicate_topic_titles = originals[:allow_duplicate_topic_titles]
end
