class Station < ActiveRecord::Base
  geocoded_by :address, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode
end
