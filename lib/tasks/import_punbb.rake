namespace :forum2discourse do
  desc "Import from PunBB to Discourse Posts and Topics"
  task :import_punbb => :environment do
    exporter = Forum2Discourse::Exporter.create(:punbb, connection_string: 'mysql://root@127.0.0.1:3306/bytemark_punbb')
    puts "Importing #{exporter.topics.size} topics"
    # Override some settings to permit import
    originals = {
      max_word_length: SiteSetting.max_word_length,
      title_min_entropy: SiteSetting.title_min_entropy,
      min_topic_title_length: SiteSetting.min_topic_title_length,
      allow_duplicate_topic_titles: SiteSetting.allow_duplicate_topic_titles?
    }
    SiteSetting.min_topic_title_length = 1
    SiteSetting.title_min_entropy = 0
    SiteSetting.max_word_length = 65535
    SiteSetting.allow_duplicate_topic_titles = true
    exporter.topics.each do |topic|
      puts "Importing '#{topic.title}'"
      u = User.admins.first
      g = Guardian.new(u)
      TopicCreator.new(u, g, topic.serialize).create
    end
    # Reset settings to defaults
    SiteSetting.max_word_length = originals[:max_word_length]
    SiteSetting.min_topic_title_length = originals[:min_topic_title_length]
    SiteSetting.title_min_entropy = originals[:title_min_entropy]
    SiteSetting.allow_duplicate_topic_titles = originals[:allow_duplicate_topic_titles]
  end
end
