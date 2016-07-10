module WebComicCrawler
  module Models
    class Comic
      attr_accessor :title, :url, :author, :image_url, :description

      def initialize(params)
        @url         = params[:url]
        @title       = params[:title]
        @author      = params[:author]
        @image_url   = params[:image_url]
        @description = params[:description]
      end

      def self.create(params)
        params[:title]
      end
    end
  end
end
