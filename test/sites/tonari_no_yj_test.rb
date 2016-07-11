require 'test_helper'

class TonariNoYJTest < Minitest::Test
  def setup
    @yj = WebComicCrawler::Sites::TonariNoYJ.new
  end

  def test_analyze
    assert @yj.analyze
  end

  def test_url_list
    url = "http://www.tonarinoyj.jp/manga/onepanman/"
    assert_equal url, @yj.url_list.first
  end

  def test_title
    assert_equal "ワンパンマン", @yj.titles.first
  end

  def test_authors
    assert_equal "原作/ＯＮＥ", @yj.authors[0][0]
  end

  def test_image_url
    image_url = "http://www.tonarinoyj.jp/manga/assets/assets_c/2015/04/onepunchman-tn-thumb-180xauto-239.jpg"
    assert_equal image_url, @yj.image_url_list.first
  end

  def test_description
    url = "http://www.tonarinoyj.jp/manga/onepanman"
    description = @yj.description(url)
    expect =<<EOS
時代が求めたニューヒーロー『一撃男』と言えば?!?\r
『WEB界のカリスマ』と『最強ジャンプ遺伝子』の超強力タッグが描き出す！ 平熱系最強ヒーロー“サイタマ”の日常ノックアウトコミック!!\r
\r
ニコニコ静画「ワンパンマン静止画MADコンテスト」グランプリ受賞作決定！\r
詳細はこちらから！\r
EOS
    assert_equal expect, description
  end

  def test_story_titles
    url = "http://www.tonarinoyj.jp/manga/onepanman"
    stories = @yj.stories(url)
    assert_equal "ワンパンマン : ", stories
  end
end
