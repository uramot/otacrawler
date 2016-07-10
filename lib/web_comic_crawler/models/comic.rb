require "active_record"

module WebComicCrawler
  module Models
    class Comic < ActiveRecord::Base
      validates :url, presence: true, uniqueness: true
      validates :title, presence: true
    end
  end
end
