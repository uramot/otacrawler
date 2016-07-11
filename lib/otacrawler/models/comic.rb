require "active_record"

module Otacrawler
  module Models
    class Comic < ActiveRecord::Base
      has_many :stories
      has_many :writing
      has_many :authors, through: :writing

      validates :url, presence: true, uniqueness: true
      validates :title, presence: true
    end
  end
end
