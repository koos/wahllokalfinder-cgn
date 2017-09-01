class AddNumberVarietyToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :number_variety, :string
  end
end
