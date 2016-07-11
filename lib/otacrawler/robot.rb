module Otacrawler
  class Robot
    def run
      collector = Collector.new("http://www.tonarinoyj.jp")
      collector.collect(%r[/manga/\w+/\Z])
    end
  end
end
