namespace :import do
  desc 'import wahllokale from csv'

  def files_list
    FileList.new("docs/*")
  end

  def terminate
    puts 'Sorry, try again!'
    exit(1)
  end

  def select_csv_file(csv_type)
    directory_to_load = ''
    STDOUT.puts "Please provide addresses folder:"
    files_list.each_with_index do |file, i|
      STDOUT.puts " #{i + 1} => #{file}"
    end

    selected_index = STDIN.gets.chomp
    terminate unless selected_index.to_i.between?(1, files_list.length)
    directory_to_load = files_list[selected_index.to_i - 1]

    year_to_load = ''
    STDOUT.puts "What is the year to be loaded?"
    year_to_load = STDIN.gets.chomp

    selected_csv_file = "#{directory_to_load}/bundestagswahl-#{year_to_load}/#{csv_type}.csv"
    puts selected_csv_file
    unless File.exist?(selected_csv_file)
      terminate
    else
      selected_csv_file
    end
  end

  task stations: :environment do
    stations_csv = select_csv_file('Stations')
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
    addresses_csv = select_csv_file('Addresses')
    addresses = SmarterCSV.process(addresses_csv, col_sep: ";")
    addresses.each do |a|
      ad = Address.create a; p "Imported: #{ad.id}: #{ad.street}"
    end
  end
end
