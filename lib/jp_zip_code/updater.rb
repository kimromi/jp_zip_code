module JpZipCode
  class Updater
    def initialize(dry_run = true)
      @dry_run = dry_run
      @jp_filer = JpZipCode::Filer.new(:jp)
      @roman_filer = JpZipCode::Filer.new(:roman)
    end

    def execute
      jp_data    = @jp_filer.fetch_data
      roman_data = @roman_filer.fetch_data
      merged     = merge(jp_data, roman_data)
      update_file(merged)

      [@jp_filer, @roman_filer].map(&:clean)
      true
    rescue => e
      puts "update failed. reason: #{e.message}"
      false
    end

    def merge(jp_data, roman_data)
      jp_data.each_with_object({}) do |(zip_code, data), merged|
        d = data.dup
        roman = roman_data[zip_code]
        d[:pref_roman] = roman ? roman[:pref_roman] : nil
        d[:city_roman] = roman ? roman[:city_roman] : nil
        d[:town_roman] = roman ? roman[:town_roman] : nil
        merged[zip_code] = d
      end
    end

    def update_file(zip_code_data)
      unless @dry_run
        (0..9999).each do |index|
          top_four = format('%04d', index)
          d = zip_code_data.select { |data| data.start_with?(top_four) }

          unless d.empty?
            File.open("#{File.dirname(__FILE__)}/../../data/zip_code/#{top_four}.json", 'w') do |file|
              file.puts JSON.generate(d)
            end
          end
          print '.' if index % 100 == 0
        end
      end
      puts "\nupdate complete."
    end
  end
end
