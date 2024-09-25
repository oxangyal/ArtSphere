class AddFieldsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :material, :string
    add_column :products, :original, :boolean
    add_column :products, :year, :integer
    add_column :products, :artist_name, :string
  end
end
