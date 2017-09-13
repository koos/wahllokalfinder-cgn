load 'lib/modules/rake_helper.rake'

namespace :validator do
  desc 'validate existed csv files'

  task city_address_zip: :environment do
    zip_codes = []
    zip_codes_count = []
    zip_codes_string = ''

    addresses_csv = RakeHelper::select_csv_file('Addresses')
    addresses = SmarterCSV.process(addresses_csv, col_sep: ";")
    addresses.map do |address|
      zip_codes.push(address[:zip])
    end
    puts "\n\n----------------------------------\n"
    zip_codes.uniq.each_with_index do |zip, i|
      zip_codes_count.push({zip: zip, count: zip_codes.count(zip)})
      zip_codes_string += "#{zip}#{(zip_codes.uniq.length == i+1 ) ? '' : ', '}" unless (zip == '' || zip === nil)
    end
    zip_codes_count.sort_by{|x| x[:count]}.reverse.each do |zip_count|
      puts "'#{zip_count[:zip]}' => is repeated #{zip_count[:count]} time(s)"
    end
    puts "----------------------------------\n\n"
    puts "[ #{zip_codes_string} ] \n\n"
  end

  task remove_stations_quotes: :environment do
    # this task removes double quotes from csv stations files
    filtered_content_count = 0
    year = RakeHelper::input_year
    folders_list = RakeHelper::folders_list
    folders_list.each do |folder|
      selected_csv_file = "#{folder}/bundestagswahl-#{year}/Stations.csv"
      prefiltered_content = File.read(selected_csv_file)
      filtered_content = prefiltered_content.gsub('"', '')
      filtered_content_count += 1 unless (prefiltered_content == filtered_content)
      File.open(selected_csv_file, 'w') do |f|
        f.puts filtered_content
      end
    end

    puts "\n #{filtered_content_count} filtered from #{folders_list.length} files were scanned.\n "

  end
end
