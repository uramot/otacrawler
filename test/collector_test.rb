require 'test_helper'

class CollectorTest < Minitest::Test
  def setup
    @url = "http://www.tonarinoyj.jp"
    @collector = Otacrawler::Collector.new(@url)
  end

  def test_collect
    pattern = "//div[@class='home-manga-item-body']"
    assert_instance_of Nokogiri::XML::Element, @collector.collect(pattern).first
  end
end
