# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'otacrawler/version'

Gem::Specification.new do |spec|
  spec.name          = "otacrawler"
  spec.version       = Otacrawler::VERSION
  spec.authors       = ["yuta-muramoto"]
  spec.email         = ["s1513114@u.tsukuba.ac.jp"]

  spec.summary       = %q{This is web comic crawler.}
  spec.description   = %q{This is web comic crawler that Akihabara otaku.}
  spec.homepage      = "https://github.com/yuta-muramoto/otacrawler.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'mem'
  spec.add_dependency 'anemone'
  spec.add_dependency 'activerecord'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency 'mysql2'
end
