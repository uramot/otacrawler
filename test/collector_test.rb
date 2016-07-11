require 'test_helper'

class CollectorTest < Minitest::Test
  def setup
    @url = "http://www.tonarinoyj.jp"
    pattern = "//div[@class='home-manga-item-body']"
    @collector = Otacrawler::Collector.new(@url)
    @comics = @collector.collect(pattern)
  end

  def test_collect_comic_url
    path = @comics[0].css('a').first.attributes["href"].to_s
    url = File.join(@url, path)
    expect = File.join(@url, "manga/onepanman/")
    assert_equal expect, url
  end

  def test_collect_comic_title
    title = @comics[0].css('h3').first.inner_text
    expect = "ワンパンマン"
    assert_equal expect, title
  end

  def test_collect_comic_author
    author = @comics[0].css('p').first.inner_text
    expect = "原作/ＯＮＥ　作画/村田雄介"
    assert_equal expect, author
  end

  def test_collect_comic_image_url
    pattern = "//figure[@class='home-manga-item-figure']"
    comics = @collector.collect(pattern)
    path = comics[0].css('img').first.attributes["src"].to_s
    image_url = File.join(@url, path)
    expect = "http://www.tonarinoyj.jp/manga/assets/assets_c/2015/04/onepunchman-tn-thumb-180xauto-239.jpg"
    assert_equal expect, image_url
  end

  def test_collect_comic_description
    url = File.join(@url, "manga/onepanman/")
    collector = Otacrawler::Collector.new(url)
    pattern = "//div[@class='single-story']"
    comics = collector.collect(pattern)
    description = comics[0].css('p').first.inner_text
    expect =<<EOS
時代が求めたニューヒーロー『一撃男』と言えば?!?\r
『WEB界のカリスマ』と『最強ジャンプ遺伝子』の超強力タッグが描き出す！ 平熱系最強ヒーロー“サイタマ”の日常ノックアウトコミック!!\r
\r
ニコニコ静画「ワンパンマン静止画MADコンテスト」グランプリ受賞作決定！\r
詳細はこちらから！\r
EOS
    assert_equal expect, description
  end
end
