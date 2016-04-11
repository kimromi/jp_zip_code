require 'open-uri'
require 'zip'
require 'yaml'

module JpZipCode
  module Filer
    class Roman < Base
      def initialize
        self.download_url = 'http://www.post.japanpost.jp/zipcode/dl/roman/ken_all_rome.zip'
      end

      def to_hash(row)
        datas = row.split(',').map(&:strip)
        {
          zip_code:   datas[0],
          pref_kanji: datas[1],
          city_kanji: datas[2],
          town_kanji: datas[3],
          pref_roman: datas[4],
          city_roman: datas[5],
          town_roman: datas[6]
        }
      end
    end
  end
end
