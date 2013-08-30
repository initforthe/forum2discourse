module Forum2Discourse
  VERSION = "0.0.0"
end

require 'forum2discourse/tasks'
require 'forum2discourse/exporter'
# Exporters
require 'forum2discourse/exporters/punbb'
require 'forum2discourse/exporters/vanilla'
require 'forum2discourse/exporters/smf'
require 'forum2discourse/models/discourse'
