class AddNumbersToAddresses < ActiveRecord::Migration[5.1]
  add_column :addresses, :number_from, :integer
  add_column :addresses, :number_to, :integer
end
