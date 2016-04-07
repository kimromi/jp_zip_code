require 'open-uri'
require 'zip'
require 'yaml'

module JpZipCode
  module Filer
    class Base
      attr_accessor :download_url, :not_found

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
            row_data = to_hash(row)
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

      def clean
        File.delete(zip_file_name) if File.exist?(zip_file_name)
      end
    end
  end
end
