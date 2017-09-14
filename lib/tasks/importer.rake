load 'lib/modules/rake_helper.rake'

namespace :import do
  desc 'import wahllokale from csv'

  task stations: :environment do
    stations_csv = RakeHelper::select_csv_file('Stations')
    stations = SmarterCSV.process(stations_csv, col_sep: ";")
    stations.each do |station|
      vote_districts = station[:vote_district_id].to_s.split(',').map(&:strip)
      vote_districts.each do |district|
        station[:vote_district_id] = district
        station[:barrier_free] = station[:wheelchair_station] == "j" ? true : false
        station[:address] = "#{station[:address_street]} #{station[:address_nr]} #{station[:address_nr_note]}, #{station[:zip]} #{station[:full_address]}"
        s = Station.create station.except(:address_nr, :address_nr_note, :address_street, :wheelchair_station)
        p "Splitted Vote District: #{s.name}, #{s.vote_district_id}"
      end
    end
  end

  task addresses: :environment do
    addresses_csv = RakeHelper::select_csv_file('Addresses')
    addresses = SmarterCSV.process(addresses_csv, col_sep: ";")
    addresses.each do |address|
      unless address[:street].nil?
        address[:street] = address[:street].gsub('straße', 'str')
        address[:street] = address[:street].gsub('Straße', 'Str')
      end
      ad = Address.create address
      puts "Imported: #{ad.id}: #{ad.street}"
    end
  end

  task cities: :environment do
    cities = RakeHelper::select_cities
    puts ' '
    cities.each do |city|
      city[:zip] = (city[:zip].is_a? Numeric) ? [city[:zip]] : city[:zip].split(/,/).map{|zip| zip.to_i}
      created_city = City.create city
      puts " + #{created_city.name} is created"
    end
    puts "\n#{cities.length} record(s)"
    puts "\nDone!\n\n"
  end
end
