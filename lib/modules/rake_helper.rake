class RakeHelper

  def self.folders_list
    FileList.new("docs/*").exclude(/.csv/)
  end

  def self.terminate_rake_task
    STDOUT.puts 'Sorry, try again!'
    exit(1)
  end

  def self.input_year
    STDOUT.print "Which year to load? (For example: 2017): "
    STDIN.gets.chomp
  end

  def self.select_csv_files(csv_type)
    directories_to_load = []
    selected_csv_files = []
    STDOUT.puts "\nWhich directory is targeted? \n\n "
    self.folders_list.each_with_index do |file, i|
      STDOUT.puts " #{i + 1} => #{file}"
    end
    STDOUT.print "\nYou can select multiple cities (Ex: 1,2,3,4,.....): "
    selected_indexs_string = STDIN.gets.chomp
    selected_cities_indexes_array = selected_indexs_string.split(/,/)
    selected_cities_indexes_array.each do |selected_index|
      self.terminate_rake_task unless selected_index.to_i.between?(1, folders_list.length)
      directories_to_load.push(self.folders_list[selected_index.to_i - 1])
    end

    year_to_load = self.input_year

    directories_to_load.each do |directory_to_load|
      selected_file = "#{directory_to_load}/bundestagswahl-#{year_to_load}/#{csv_type}.csv"
      unless File.exist?(selected_file)
        puts "The file #{selected_file} is not existed"
        self.terminate_rake_task
      end
      selected_csv_files.push(selected_file)
      puts " - selecting: #{selected_file}"
    end
    puts "\n"
    selected_csv_files
  end

  def self.select_cities
    cities = SmarterCSV.process('docs/cities.csv', col_sep: ";")
    STDOUT.print "\nDo you want to load all the cities from cities.csv? y/n : "
    load_all_cities_answer = STDIN.gets.chomp

    if (load_all_cities_answer == 'y' || load_all_cities_answer == 'yes')
      cities
    elsif (load_all_cities_answer == 'n' || load_all_cities_answer == 'no')
      STDOUT.puts "\nThese are the availbe cities:\n "
      cities.each_with_index do |city, i|
        STDOUT.puts "#{i + 1} => #{city[:name]}"
      end
      STDOUT.print "\nYou can select multiple cities (Ex: 1,2,3,4,.....) : "
      selected_cities_string = STDIN.gets.chomp
      selected_cities_indexes_array = selected_cities_string.split(/,/)
      selected_cities = []
      selected_cities_indexes_array.each do |index|
        selected_cities.push(cities[index.to_i - 1])
      end
      selected_cities
    else
      self.terminate_rake_task
    end
  end
end
