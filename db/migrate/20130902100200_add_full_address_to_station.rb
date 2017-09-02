class AddFullAddressToStation < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :full_address, :string
  end
end
