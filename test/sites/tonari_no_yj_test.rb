require 'test_helper'

class TonariNoYJTest < Minitest::Test
  def setup
    @yj = Otacrawler::Sites::TonariNoYJ.new
    @url = "http://www.tonarinoyj.jp/manga/shabettemoneko/"
    @comic = Otacrawler::Models::Comic.find_by(url: @url)
  end

  def test_analyze
    # assert @yj.analyze # This test is very slowly
  end

  def test_url_list
    assert_equal @comic.url, @yj.url_list.first
  end

  def test_title
    assert_equal @comic.title, @yj.titles.first
  end

  def test_authors
    assert_equal @comic.authors.first.name, @yj.authors[0][0]
  end

  def test_image_url
    image_url = "http://www.tonarinoyj.jp/manga/assets/assets_c/2015/04/onepunchman-tn-thumb-180xauto-239.jpg"
    assert_equal @comic.image_url, @yj.image_url_list.first
  end

  def test_description
    assert_equal @comic.description, @yj.description(@url)
  end

  def test_story_title
    url = "http://www.tonarinoyj.jp/manga/onepanman"
    stories = @yj.stories(url)
    assert_equal "ワンパンマン : ", stories.first[:title]
  end

  def test_story_url
    url = "http://www.tonarinoyj.jp/manga/onepanman"
    stories = @yj.stories(url)
    expect = "http://viewer.tonarinoyj.jp/series/FlR8CfEDwK8/FlR8CfEDwLA?manga=onepanman"
    assert_equal expect, stories.last[:url]
  end

  def test_story_relative_url_path
    url = "http://www.tonarinoyj.jp/manga/all_you_need_is_kill/"
    stories = @yj.stories(url)
    expect = "http://www.tonarinoyj.jp/manga/all_you_need_is_kill/20/?viewer=horizon"
    assert_equal expect, stories.first[:url]
  end

  def test_number
    url = "http://www.tonarinoyj.jp/manga/onepanman"
    stories = @yj.stories(url)
    assert_equal 1, stories.last[:number]
  end
end
