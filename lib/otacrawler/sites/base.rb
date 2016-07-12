module Otacrawler
  module Sites
    class Base
      def self.inherited(child)
        Otacrawler.sites << child
      end
    end
  end
end
