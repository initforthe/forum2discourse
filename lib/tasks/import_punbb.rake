namespace :forum2discourse do
  desc "Import from PunBB to Discourse Posts and Topics"
  task :import_punbb => :environment do
    exporter = Forum2Discourse::Exporter.create(:punbb, connection_string: 'mysql://root@127.0.0.1:3306/bytemark_punbb')
    puts "Importing #{exporter.topics.size} topics"
    # Override some settings to permit import
    SiteSetting.min_topic_title_length = 1
    SiteSetting.title_min_entropy = 1
    exporter.topics.each do |topic|
      u = User.admins.first
      g = Guardian.new(u)
      TopicCreator.new(u, g, topic.serialize).create
    end
    # Reset settings to defaults
    SiteSetting.min_topic_title_length = 15
    SiteSetting.title_min_entropy = 10
  end
end
