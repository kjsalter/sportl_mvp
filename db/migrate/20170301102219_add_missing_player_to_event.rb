class AddMissingPlayerToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :missing_player, :integer
  end
end
