namespace :forum2discourse do
  desc "Import from SMF to Discourse Posts and Topics"
  task :import_smf => :environment do
    require 'forum2discourse/importer'
    if ENV['F2D_CONNECTION_STRING'].blank?
      puts "You must specify a connection string"
      puts " i.e.: export F2D_CONNECTION_STRING=mysql://root@host-ip:3306/database"
      exit
    end
    # 'mysql://root@127.0.0.1:3306/bytemark_punbb
    puts "creating exporter"
    exporter = Forum2Discourse::Exporter.create(:smf, connection_string: ENV['F2D_CONNECTION_STRING'])
    puts "creating importer"
    importer = Forum2Discourse::Importer.new()
    offset=0
    while topics = exporter.topicsSlice(offset, 1) do
      topics.each do |topic|
        importer.import_topic(topic.to_discourse)
        topic = nil
      end
      topics = nil
      offset += 1
      
      counts = Hash.new{ 0 }
      ObjectSpace.each_object do |o|
        counts[o.class] += 1
      end
      
      counts.each_pair do |k,v|
        if v>50
            puts "#{k}  = #{v}"
        end
      end
    end
  end
end

