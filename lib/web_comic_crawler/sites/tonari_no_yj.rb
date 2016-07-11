require "memoizable"

module WebComicCrawler
  module Sites
    class TonariNoYJ
      include Memoizable

      def initialize
        @url = "http://www.tonarinoyj.jp"
        @collector = Collector.new(@url)
      end

      def analyze
        url_list.each_with_index do |url, i|
          params = { url: url, title: titles[i] }
          comic = Models::Comic.new(params)
          if comic.save
            create(comic, i)
          else
            update(url, i)
          end
        end
      end

      def url_list
        item_body.map do |comic|
          path = comic.css('a').first.attributes["href"].to_s
          File.join(@url, path)
        end
      end
      memoize :url_list

      def titles
        item_body.map do |comic|
          comic.css('h3').first.inner_text
        end
      end
      memoize :titles

      def authors
        item_body.map do |comic|
          authors = comic.css('p').first.inner_text
          authors.split(/[[:space:]]/)
        end
      end
      memoize :authors

      def image_url_list
        pattern = "//figure[@class='home-manga-item-figure']"
        comics = @collector.collect(pattern)
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
        comic.first.css('p').first.inner_text
      rescue
        ""
      end

      private

      def create(comic, i)
        comic.image_url = image_url_list[i]
        comic.description = description(comic.url)
        authors[i].each do |author|
          comic.authors.build({ name: author })
        end
        comic.save
      end

      def update(url, i)
        comic = Models::Comic.find_by(url: url)
        create(comic, i)
      end

      def item_body
        pattern = "//div[@class='home-manga-item-body']"
        @collector.collect(pattern)
      end
      memoize :item_body
    end
  end
end
