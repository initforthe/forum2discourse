$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name          = "forum2discourse"
  s.version       = "0.0.0"
  s.date          = "2013-06-26"
  s.summary       = "Exports various forums data structures to discourse"
  s.description   = "Exports through a database connection various forums to discourse json format. Initially supporting PunBB"
  s.authors       = ["Tom Russell"]
  s.email         = "tom.russell@initforthe.com"
  s.files         = %w(README.md)
  s.files        += Dir.glob("lib/**/*.rb")
  s.homepage      = "http://initforthe.com"
  s.executables << 'forum2discourse'
  s.add_dependency 'data_mapper'
  s.add_dependency 'dm-postgres-adapter'
  s.add_dependency 'dm-mysql-adapter'
end
