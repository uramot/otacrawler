require "test_helper"

class StoryTest < Minitest::Test
  def setup
    @story = WebComicCrawler::Models::Story.new
  end
end
