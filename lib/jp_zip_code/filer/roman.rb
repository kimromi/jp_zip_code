require 'open-uri'
require 'zip'
require 'yaml'

module JpZipCode
  module Filer
    class Roman < Base
      def initialize
        self.download_url = 'http://www.post.japanpost.jp/zipcode/dl/roman/ken_all_rome.zip'
        self.not_found = %w(IKANIKEISAIGANAIBAAI 以下に掲載がない場合)
      end

      def to_hash(row)
        datas = row.split(',').map { |d| convert(d) }
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

      def convert(roman)
        converted = not_found.include?(roman) ? '' : roman # 'IKANIKEISAIGANAIBAAI' => ''
        converted = converted.gsub(/\(.*\)/, '').gsub(/（.*）/, '') # hoge(1chome) => hoge
        converted = converted.split(' ').map(&:capitalize).join(' ')   # TOKYO TO => Tokyo To
        roman_suffixes.each do |suffix|
          converted = converted.gsub(/ #{suffix}/, "-#{suffix}")       # Tokyo To => Tokyo-To
        end
        converted
      end

      def roman_suffixes
        %w(
          Ken
          To
          Fu
          Shi
          Gun
          Ku
          Machi
        )
      end
    end
  end
end
