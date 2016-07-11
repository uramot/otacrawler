require "active_record"

module Otacrawler
  module Models
    class Story < ActiveRecord::Base
      belongs_to :comics
    end
  end
end
