Otacrawler
===

Otacrawler is web comic crawler such as the Akihabara otaku.
<img src="img/IMG_6837.JPG" align="right">

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'otacrawler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crawler

## Usage

Run robot:

```sh
$ bin/otacrawler
```

## Development

If you want to add crawling sites, you add that site to `Otacrawler::Sites`. At that time, you should inherit the site from `Otacrawler::Sites::Base`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yuta-muramoto/otacrawler.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
