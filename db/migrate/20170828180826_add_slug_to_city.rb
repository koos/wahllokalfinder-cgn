class AddSlugToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :slug, :string
  end
end
