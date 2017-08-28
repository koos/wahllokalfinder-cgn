namespace :import do
  desc 'import wahllokale from csv'
  task stations: :environment do
    stations = SmarterCSV.process("doc/koeln/landtagswahl-2017/2017-05-10-1-barrierefrei-wahllokale.csv", col_sep: ";")
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
    addresses = SmarterCSV.process("doc/koeln/landtagswahl-2017/2017-05-12-adressen.csv", col_sep: ";")
    addresses.each { |a| ad = Address.create a; p "Imported: #{ad.id}: #{ad.street}" }
  end
end
