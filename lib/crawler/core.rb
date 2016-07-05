require 'anemone'

module Crawler
  class Core
    def initialize
      @manga = []
    end

    def run
      Anemone.crawl('http://www.tonarinoyj.jp/#running', depth_limit: 0) do |anemone|
        anemone.on_pages_like(%r[/manga/.*]) do |page|
          puts page.url
        end
      end
    end
  end
end
