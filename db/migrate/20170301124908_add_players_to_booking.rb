class AddPlayersToBooking < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :no_players, :integer
  end
end
