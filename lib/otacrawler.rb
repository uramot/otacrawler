require "otacrawler/version"
require "otacrawler/collector"
require "otacrawler/robot"
require "otacrawler/sites/tonari_no_yj"
require "otacrawler/models/comic"
require "otacrawler/models/author"
require "otacrawler/models/story"
require "otacrawler/models/writing"

require "active_record"
require "erb"

module Otacrawler
  config = YAML.load(ERB.new(IO.read("database.yml")).result)
  ActiveRecord::Base.establish_connection(config["db"]["development"])
end
