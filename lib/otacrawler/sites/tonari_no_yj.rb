require "mem"
require 'uri'

module Otacrawler
  module Sites
    class TonariNoYJ < Base
      include Mem

      def initialize
        @url = "http://www.tonarinoyj.jp"
        @collector = Collector.new(@url)
      end

      def analyze
        url_list.each_with_index do |url, i|
          params = { url: url, title: titles[i] }
          comic = Models::Comic.new(params)
          if comic.save # overlapping check
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
        css = 'figure.home-manga-item-figure'
        comics = items.map {|item| item.css(css) }
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

      def stories(url)
        collector = Collector.new(url)
        pattern = "//div[@class='single-backnumber']/dl"
        stories = collector.collect(pattern)
        result = stories.map do |story|
          unless story.css('dt').empty?
            title = story.css('dt').first.inner_text
          else
            title = ""
          end
          story.css('li').map do |number|
            path = number.css('a').first.attributes["href"].to_s
            {
              url:    URI.join(@url, path).to_s,
              title:  title,
              number: number.inner_text.to_i
            }
          end
        end
        result.flatten
      end

      private

      def create(comic, i)
        comic.image_url = image_url_list[i]
        comic.description = description(comic.url)
        authors[i].each do |author|
          comic.authors.build({ name: author })
        end
        stories(comic.url).each do |story|
          comic.stories.build(story)
        end
        comic.save
      end

      def update(url, i)
        comic = Models::Comic.find_by(url: url)
        comic.image_url = image_url_list[i]
        comic.description = description(url)
        comic.save
        update_author(url, i)
        update_story(url, i)
      end

      def update_author(url, i)
        comic = Models::Comic.find_by(url: url)
        authors[i].each do |author|
          comic.authors.build({ name: author })
        end
        comic.save
      end

      def update_story(url, i)
        comic = Models::Comic.find_by(url: url)
        stories(url).each do |story|
          comic.stories.build(story)
        end
        comic.save
      end

      def items
        pattern = "//div[@class='home-manga-item-wrapper']"
        @collector.collect(pattern)
      end
      memoize :items

      def item_body
        css = 'div.home-manga-item-body'
        items.map {|item| item.css(css) }
      end
      memoize :item_body
    end
  end
end
