require 'data_mapper'
require 'dm-mysql-adapter'

module TestDatabase
  # XXX This will need refactoring when >1 format is used.
  TEST_DATABASE_CONNECTION_STRING = "mysql://root@127.0.0.1:3306/forum2discourse_test"

  def self.prepare
    DataMapper::Logger.new($stdout, :info)
    DataMapper.setup(:test, TEST_DATABASE_CONNECTION_STRING)
    execute_queries_from(forums_sql)
    execute_queries_from(posts_sql)
    execute_queries_from(topics_sql)
  end

  def self.execute_queries_from(sql)
    # Datamapper won't execute queries containing ';'
    sql.split(';').each do |statement|
      next if statement.chomp.empty?
      begin
        DataMapper.repository(:test).adapter.execute(statement)
      rescue DataObjects::SQLError
        puts "Failed with statement: "
        puts statement.inspect
        raise
      end
    end
  end

  def self.forums_sql
    File.open("#{RSPEC_ROOT}/test_data/forums.sql", 'r') { |f| f.read }
  end

  def self.posts_sql
    File.open("#{RSPEC_ROOT}/test_data/posts.sql", 'r') { |f| f.read }
  end

  def self.topics_sql
    File.open("#{RSPEC_ROOT}/test_data/topics.sql", 'r') { |f| f.read }
  end
end
