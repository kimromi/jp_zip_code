# JpZipCode

convert from zip-code to japan address (include Roman address)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jp_zip_code'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jp_zip_code

## Usage

```
address = JpZipCode.search '100-0001'

address.pref_kanji    # => 東京都
address.city_kanji    # => 千代田区
address.town_kanji    # => 千代田
address.pref_kana     # => ﾄｳｷｮｳﾄ
address.city_kana     # => ﾁﾖﾀﾞｸ
address.town_kana     # => ﾁﾖﾀﾞ
address.pref_roman    # => Tokyo-To
address.city_roman    # => Chiyoda-Ku
address.town_roman    # => Chiyoda
address.zip_code      # => 1000001

JpZipCode.update      # update json file
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

