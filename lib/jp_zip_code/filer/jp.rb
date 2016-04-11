require 'open-uri'
require 'zip'
require 'yaml'

module JpZipCode
  module Filer
    class Jp < Base
      def initialize
        self.download_url = 'http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip'
      end

      def to_hash(row)
        datas = row.split(',').map(&:strip)
        {
          code:         datas[0],
          old_zip_code: datas[1],
          zip_code:     datas[2],
          pref_kana:    datas[3],
          city_kana:    datas[4],
          town_kana:    datas[5],
          pref_kanji:   datas[6],
          city_kanji:   datas[7],
          town_kanji:   datas[8]
        }
      end

    end
  end
end
