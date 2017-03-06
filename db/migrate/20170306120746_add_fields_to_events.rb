class AddFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :venue_name, :string
    add_column :events, :address, :string
    add_column :events, :country, :string
  end
end
