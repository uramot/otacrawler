require 'test_helper'

class ServiceTest < Minitest::Test
  def setup
    @service = WebComicCrawler::Service.new
  end
end
