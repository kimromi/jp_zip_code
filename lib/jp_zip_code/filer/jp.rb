require 'open-uri'
require 'zip'
require 'yaml'

module JpZipCode
  module Filer
    class Jp < Base
      def initialize
        self.download_url = 'http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip'
        self.not_found = %w(ｲｶﾆｹｲｻｲｶﾞﾅｲﾊﾞｱｲ 以下に掲載がない場合)
      end

      def to_hash(row)
        datas = row.split(',').map { |d| convert(d) }
        {
          code:         datas[0],
          old_zip_code: datas[1],
          zip_code:     datas[2],
          pref_kana:    datas[3],
          city_kana:    datas[4],
          town_kana:    datas[5],
          pref_kanji:   datas[6],
          city_kanji:   datas[7],
          town_kanji:   datas[8],
          pref_code:    pref_codes.invert[datas[6]].to_s
        }
      end

      def convert(str)
        converted = not_found.include?(str) ? '' : str # '以下に掲載がない場合' => ''
        converted = converted.gsub(/\(.*\)/, '').gsub(/（.*）/, '') # 例町（１丁目） => 例町
        converted
      end

      def pref_codes
        @pref_codes ||= YAML.load(File.open('data/pref_code.yaml'))
      end
    end
  end
end
