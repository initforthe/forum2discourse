namespace :forum2discourse do
  desc "Import from Vanilla to Discourse Posts and Topics"
  task :import_vanilla => :environment do
    require 'forum2discourse/importer'
    if ENV['F2D_CONNECTION_STRING'].blank?
      puts "You must specify a connection string"
      puts " i.e.: export F2D_CONNECTION_STRING=mysql://root@host-ip:3306/database"
      exit
    end
    # 'mysql://root@127.0.0.1:3306/bytemark_punbb
    exporter = Forum2Discourse::Exporter.create(:vanilla, connection_string: ENV['F2D_CONNECTION_STRING'])
    binding.pry
    Forum2Discourse::Importer.new(exporter.topics).import
  end
end

