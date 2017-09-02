class AddCityHousingTypeToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :city_housing_type, :integer
  end
end
