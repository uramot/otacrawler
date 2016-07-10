require "active_record"

module WebComicCrawler
  module Models
    class Author < ActiveRecord::Base
      has_many :writing
      has_many :comics, through: :writing

      validates :name, presence: true, uniqueness: true
    end
  end
end
