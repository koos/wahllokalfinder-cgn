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

  def self.select_csv_file(csv_type)
    directory_to_load = ''
    STDOUT.puts "\nWhich directory is targeted?\n\n "
    folders_list.each_with_index do |file, i|
      STDOUT.puts " #{i + 1} => #{file}"
    end
    STDOUT.print "\nSelect a number: "
    selected_index = STDIN.gets.chomp
    self.terminate_rake_task unless selected_index.to_i.between?(1, folders_list.length)
    directory_to_load = folders_list[selected_index.to_i - 1]

    year_to_load = self.input_year

    selected_csv_file = "#{directory_to_load}/bundestagswahl-#{year_to_load}/#{csv_type}.csv"
    STDOUT.puts selected_csv_file
    unless File.exist?(selected_csv_file)
      self.terminate_rake_task
    else
      selected_csv_file
    end
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
