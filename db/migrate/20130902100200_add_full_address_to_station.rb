class AddFullAddressToStation < ActiveRecord::Migration
  def change
    add_column :stations, :full_address, :string
  end
end
