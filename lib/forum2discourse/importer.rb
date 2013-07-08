class Forum2Discourse::Importer
  def initialize(topics)
    @topics = topics
    @categories = []
  end

  def log(message)
    puts message unless ENV['F2C_LOG_LEVEL'].to_i < 1
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
    log "Importing '#{topic.title}'"
    user = discourse_user(topic.posts.first.user)
    guardian = Guardian.new(user)
    find_or_create_category(user, topic.category)
    discourse_topic = TopicCreator.new(user, guardian, topic.serialize).create
    import_topic_posts(discourse_topic, topic.posts)
  end

  def find_or_create_category(user, category)
    unless @categories.include? category
      @categories << Category.create_with(user: user).find_or_create_by_name(category)
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
      user
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

  def reset_settings_to(originals)
    SiteSetting.max_word_length = originals[:max_word_length]
    SiteSetting.min_topic_title_length = originals[:min_topic_title_length]
    SiteSetting.title_min_entropy = originals[:title_min_entropy]
    SiteSetting.allow_duplicate_topic_titles = originals[:allow_duplicate_topic_titles]
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
      SiteSetting.title_min_entropy = nil
      SiteSetting.max_word_length = 65535
      SiteSetting.allow_duplicate_topic_titles = true
    end
  end
end
