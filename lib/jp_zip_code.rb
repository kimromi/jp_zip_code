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
      Hashie::Rash.new(convert(data[zip_code]))
    end
  end

  def self.convert(data)
    data.each_with_object({}) do |(key, value), hash|
      converted = %w(ｲｶﾆｹｲｻｲｶﾞﾅｲﾊﾞｱｲ IKANIKEISAIGANAIBAAI 以下に掲載がない場合).include?(value) ? '' : value
      converted = converted.gsub(/\(.*\)/, '').gsub(/（.*）/, '')
      converted = converted.split(' ').map(&:capitalize).join(' ')
      %w(Ken To Fu Shi Gun Ku Machi).each do |suffix|
        converted = converted.gsub(/ #{suffix}/, "-#{suffix}")
      end
      hash[key] = converted
    end
  end

  def self.update
    JpZipCode::Updater.new(false).execute
  end
end
