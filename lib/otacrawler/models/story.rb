require "active_record"

module Otacrawler
  module Models
    class Story < ActiveRecord::Base
      belongs_to :comic
    end
  end
end
