require "active_record"

module WebComicCrawler
  module Models
    class Story < ActiveRecord::Base
      belongs_to :comics
    end
  end
end
