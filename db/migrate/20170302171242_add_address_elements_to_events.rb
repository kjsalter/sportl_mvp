class AddAddressElementsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :g_city, :string
    add_column :events, :g_postcode, :string
    add_column :events, :g_country, :string
  end
end
