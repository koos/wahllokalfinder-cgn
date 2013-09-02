require 'csv'

namespace :import do
  desc 'convert vimeo links to https'
  task stations: :environment do
    json_text = File.read("doc/wahllokale.geojson")
    # csv = CSV.parse(csv_text, col_sep: ';', :headers => true)
    stations = JSON.parse(json_text)['features']
    stations.each do |json|
      p json['properties']['STIMMBEZIR']
      station = Station.new
      station.vote_district_id = json['properties']['ABSTIMMBEZ'].to_i
      station.name = json['properties']["WLK_NAME"]
      station.address = json['properties']["WLK_ADRESS"]
      station.barrier_free = json['properties']['ROLLSTUHLG'].to_i
      station.district= json['properties']["STIMMBEZIR"]
      station.zip= json['properties']["POSTZUSTEL"]
      station.koor_x= json['properties']["KOORX"]
      station.koor_y= json['properties']["KOORY"]
      station.vote_district= json['properties']['NR_STIMMBE'].to_i
      station.local_election_district_id= json['properties']['KOMMUNALWA']
      station.landtag_election_district_id= json['properties']['LANDTAGSWA']
      station.bundestag_election_district_id= json['properties']['BUNDESTAGS']
      station.latitude = json['geometry']['coordinates'].first
      station.longitude = json['geometry']['coordinates'].last
      station.save
      p station.barrier_free
    end
  end
end

namespace :geocode do
  desc 'geocode missing stations'
  task stations: :environment do
    stations = Station.where('latitude IS NULL')
    p stations.count
    stations.each do |station|
      station.geocode
      p station.latitude
      station.save
    end
  end
end