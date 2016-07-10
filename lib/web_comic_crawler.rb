require "web_comic_crawler/version"
require "web_comic_crawler/collector"
require "web_comic_crawler/database"
require "web_comic_crawler/robot"
require "web_comic_crawler/sites/tonari_no_yj"
require "web_comic_crawler/models/comic"
require "web_comic_crawler/models/author"
require "web_comic_crawler/models/story"
require "web_comic_crawler/models/writing"

require "active_record"
require "erb"

module WebComicCrawler
  config = YAML.load(ERB.new(IO.read("database.yml")).result)
  ActiveRecord::Base.establish_connection(config["db"]["development"])
end
