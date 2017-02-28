class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum booking_state: [:pending, :accepted, :denied]
end
