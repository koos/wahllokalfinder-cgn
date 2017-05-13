class AddPhoneToStation < ActiveRecord::Migration
  def change
    add_column :stations, :phone, :string
  end
end
