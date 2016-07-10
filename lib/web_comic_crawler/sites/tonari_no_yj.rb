require "memoizable"

module WebComicCrawler
  module Sites
    class TonariNoYJ
      include Memoizable

      def initialize
        @url = "http://www.tonarinoyj.jp"
      end

      def analyze
        url_list.each_with_index do |url, i|
          params = {
            url: url,
            title: titles[i],
            image_url: image_url_list[i],
            description: description(url)
          }
          comic = WebComicCrawler::Models::Comic.new(params)
          comic.authors.build({ name: authors[i] })
          comic.save
        end
      end

      def url_list
        pattern = "//div[@class='home-manga-item-body']"
        collector = Collector.new(@url)
        comics = collector.collect(pattern)
        comics.map do |comic|
          path = comic.css('a').first.attributes["href"].to_s
          File.join(@url, path)
        end
      end
      memoize :url_list

      def titles
        pattern = "//div[@class='home-manga-item-body']"
        collector = Collector.new(@url)
        comics = collector.collect(pattern)
        comics.map do |comic|
          comic.css('h3').first.inner_text
        end
      end
      memoize :titles

      def authors
        pattern = "//div[@class='home-manga-item-body']"
        collector = Collector.new(@url)
        comics = collector.collect(pattern)
        comics.map do |comic|
          authors = comic.css('p').first.inner_text
        end
      end
      memoize :authors

      def image_url_list
        pattern = "//figure[@class='home-manga-item-figure']"
        collector = Collector.new(@url)
        comics = collector.collect(pattern)
        comics.map do |comic|
          path = comic.css('img').first.attributes['src'].to_s
          File.join(@url, path)
        end
      end
      memoize :image_url_list

      def description(url)
        collector = Collector.new(url)
        pattern = "//div[@class='single-story']"
        comic = collector.collect(pattern)
        comic[0].css('p').first.inner_text
      rescue
        ""
      end
    end
  end
end
