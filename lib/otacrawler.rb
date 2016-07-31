require "erb"
require "yaml"
require "mem"
require "active_record"

module Otacrawler
  config = YAML.load(ERB.new(IO.read(ENV["DATABASE_SETTING_PATH"])).result)
  ActiveRecord::Base.establish_connection(config["development"])

  class << self
    include Mem
    def sites
      []
    end
    memoize :sites
  end
end

require "otacrawler/version"
require "otacrawler/collector"
require "otacrawler/robot"
require "otacrawler/models/comic"
require "otacrawler/models/author"
require "otacrawler/models/story"
require "otacrawler/models/writing"

require "otacrawler/sites/base"
require "otacrawler/sites/tonari_no_yj"
