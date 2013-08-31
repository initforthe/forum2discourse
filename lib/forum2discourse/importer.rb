TextSentinel
class TextSentinel
  def seems_quiet?; true; end
  def seems_pronounceable?; true; end
end

class Forum2Discourse::Importer
  def initialize(topics=[])
    @topics = topics
    @categories = []
  end

  # XXX consider reimplementing this as a Logger
  def log(message)
    puts message if ENV['F2C_LOG_LEVEL'].nil? || ENV['F2C_LOG_LEVEL'].to_i > 0
  end

  def import
    with_permissive_settings do
      log "Importing #{@topics.size} topics"
      @topics.each do |topic|
        import_topic(topic) if topic.valid?
      end
    end
  end

  def import_topic(topic)
      with_permissive_settings do
        log "Importing '#{topic.title}'"
        user = discourse_user(topic.posts.first.user)
        guardian = Guardian.new(user)
        find_or_create_category(user, topic.category)
        discourse_topic = TopicCreator.new(user, guardian, topic.serialize).create
        import_topic_posts(discourse_topic, topic.posts)
      end
      rescue
        puts "FAILED TO IMPORT TOPIC #{topic.title}"
        puts "Error: #{$!.message}"
        puts $!.backtrace.join("\n")
  end

  def find_or_create_category(user, category)
    unless @categories.include? category
      if categoryobj = Category.find_or_create_by_name(category)
        @categories << categoryobj
      else
        @categories << Category.create_with(user: user).find_or_create_by_name(category)
      end
    end
  end

  def import_topic_posts(discourse_topic, posts)
    posts.each do |post|
      user = discourse_user(post.user)
      data = post.serialize.merge({topic_id: discourse_topic.id})
      PostCreator.new(discourse_user(post.user), data).create
    end
    log "  Imported #{posts.size} posts"
  end

  private

  def with_permissive_settings
    originals = set_original_settings
    yield
    reset_settings_to(originals)
  end

  def discourse_user(user)
    u = User.create_with(user.serialize).find_or_create_by_username(user.serialize[:username])
    if u.persisted?
      u
    else
      anon = Forum2Discourse::Models::Discourse::User.anonymous.serialize
      User.create_with(anon).find_or_create_by_username(anon[:username])
    end
  end

  # Certain settings we need to override for the importer are hardcoded.
  def perform_monkey_patching
    class << RateLimiter
      def disabled?; true; end
    end
  end

  PERMISSIVE_SETTINGS = {
    min_topic_title_length: 1,
    title_min_entropy: nil,
    body_min_entropy: nil,
    max_word_length: 65535,
    newuser_spam_host_threshold: 65535,
    newuser_max_links: 65535,
    newuser_max_images: 65535,
    newuser_max_mentions_per_post: 65535,
    max_mentions_per_post: 65535,
    min_post_length: 1,
    unique_posts_mins: 0,
    allow_duplicate_topic_titles: true
  }

  def reset_settings_to(originals)
    PERMISSIVE_SETTINGS.each do |setting, _|
      SiteSetting.send("#{setting}=", originals[setting])
    end
  end

  def set_original_settings
    originals = {}
    {}.tap do |originals|
      perform_monkey_patching
      PERMISSIVE_SETTINGS.each do |setting, value|
        originals[setting] = SiteSetting.send(setting)
        SiteSetting.send("#{setting}=", value)
      end
    end
  end
end
