module Otacrawler
  class Robot
    def run
      sites.each do |site|
        site.analyze
      end
    end

    def sites
      Otacrawler.sites.map {|site_class| site_class.new }
    end
  end
end
