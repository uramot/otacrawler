require 'anemone'

module WebComicCrawler
  class Collector
    def initialize(url)
      @url = url
    end

    def collect(pattern)
      comics = []
      Anemone.crawl(@url, depth_limit: 0) do |anemone|
        anemone.on_every_page do |page|
          page.doc.xpath(pattern).each do |comic|
            comics << comic
          end
        end
      end
      comics
    end
  end
end
