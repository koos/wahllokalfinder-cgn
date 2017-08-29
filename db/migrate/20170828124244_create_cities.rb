class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :slug
      t.text :zip
      t.string :state
      t.string :coordinates

      t.timestamps
    end
  end
end
