namespace :forum2discourse do
  desc "Import from PunBB to Discourse Posts and Topics"
  task :import_punbb => :environment do
    exporter = Forum2Discourse::Exporter.create(:punbb, connection_string: 'mysql://root@127.0.0.1:3306/bytemark_punbb')
    puts "Importing #{exporter.topics.size} topics"
    exporter.topics.each do |topic|
      u = User.first
      g = Guardian.new
      TopicCreator.new(u, g, topic.serialize).create
    end
  end
end
