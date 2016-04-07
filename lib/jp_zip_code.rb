require 'jp_zip_code/version'
require 'jp_zip_code/updater'
require 'jp_zip_code/filer/base'
require 'jp_zip_code/filer/jp'
require 'jp_zip_code/filer/roman'
require 'json'
require 'rash'

module JpZipCode
  def self.search(zip_code)
    zip_code = zip_code.to_s.delete('-')
    return nil unless zip_code =~ /^\d{7}$/

    json_file = "data/zip_code/#{zip_code[0, 4]}.json"
    if File.exist?(json_file)
      data = File.open(json_file) { |json| JSON.load(json) }
      Hashie::Rash.new(data[zip_code])
    end
  end

  def self.update
    JpZipCode::Updater.new(false).execute
  end
end
