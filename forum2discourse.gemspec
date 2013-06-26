Gem::Specification.new do |s|
  s.name          = "forum2discourse"
  s.version       = "0.0.0.pre"
  s.date          = "2013-06-26"
  s.summary       = "Exports various forums data structures to discourse"
  s.description   = "Exports through a database connection various forums to discourse json format. Initially supporting PunBB"
  s.authors       = ["Tom Russell"]
  s.email         = "tom.russell@initforthe.com"
  s.files        += Dir.glob("lib/**/*.rb")
  puts s.files.inspect
  s.homepage      = "http://initforthe.com"
  s.executables << 'forum2discourse'
end
