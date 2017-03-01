class AddColToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :active, :boolean, :default => true
  end
end
