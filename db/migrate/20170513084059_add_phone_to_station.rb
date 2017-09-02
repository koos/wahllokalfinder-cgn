class AddPhoneToStation < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :phone, :string
  end
end
