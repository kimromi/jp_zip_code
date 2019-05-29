require 'open-uri'
require 'zip'
require 'yaml'

module JpZipCode
  class Filer
    def initialize(type)
      @type = type.to_sym
    end

    def download_url
      case @type
      when :jp
        'https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip'
      when :roman
        'https://www.post.japanpost.jp/zipcode/dl/roman/ken_all_rome.zip'
      end
    end

    def fetch_data
      download_file
      unzip_file_and_get_data
    end

    def zip_file_name
      File.basename(download_url)
    end

    def download_file
      open(zip_file_name, 'wb') do |file|
        open(download_url) do |data|
          file.write(data.read)
        end
      end
    end

    def unzip_file_and_get_data
      hash = {}
      unzip(zip_file_name) do |file|
        get_row(file).each do |row|
          row_data = to_hash(row.split(',').map(&:strip))
          hash[row_data[:zip_code]] = row_data
        end
      end
      hash
    end

    def unzip(file_name)
      Zip::File.open(file_name) do |csv_files|
        csv_files.each do |file|
          yield(file)
        end
      end
    end

    def get_row(file)
      file.get_input_stream.read.encode('utf-8', 'cp932').delete('"').split("\n")
    end

    def to_hash(datas)
      case @type
      when :jp
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
      when :roman
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

    def clean
      File.delete(zip_file_name) if File.exist?(zip_file_name)
    end
  end
end
