require 'test_helper'

class ComicTest < Minitest::Test
  def setup
    params = {
      title: 'ウェブ漫画',
      url: 'http://example.com/manga/webmanga',
      author: ['漫画太郎'],
      image_url: 'http://example.com/webmanga.jpg',
      description: 'テスト用のマンガ'
    }
    @comic = WebComicCrawler::Models::Comic.new(params)
  end

  def test_title
    assert_equal 'ウェブ漫画', @comic.title
  end

  def test_url
    assert_equal 'http://example.com/manga/webmanga', @comic.url
  end

  def test_author
    assert_equal ['漫画太郎'], @comic.author
  end

  def test_image_url
    assert_equal 'http://example.com/webmanga.jpg', @comic.image_url
  end

  def test_description
    assert_equal 'テスト用のマンガ', @comic.description
  end
end
