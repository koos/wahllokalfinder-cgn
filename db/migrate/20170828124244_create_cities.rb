class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.text :zip
      t.string :state

      t.timestamps
    end
  end
end
