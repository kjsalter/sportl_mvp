class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum booking_state: [:pending, :accepted, :denied]

  def booking_denied
    self.event.missing_player += self.no_players
    self.event.save
  end
end
