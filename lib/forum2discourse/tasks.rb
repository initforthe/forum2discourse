if defined?(Rails) && defined?(Rake)
  class Forum2Discourse::Tasks < Rails::Railtie
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), '../tasks/*.rake')].each { |f| load f }
    end
  end
end
