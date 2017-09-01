class City < ApplicationRecord
  serialize :zip, Array
  enum city_housing_type: ['normal', 'odd_even', 'horseshoe']
end
