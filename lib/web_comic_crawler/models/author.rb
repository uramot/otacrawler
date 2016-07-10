require "active_record"

module WebComicCrawler
  module Models
    class Author < ActiveRecord::Base
      validates :name, presence: true, uniqueness: true
    end
  end
end
