class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def accept_booking
    # booking_state = 1 means accepted
    @booking.booking_state = 1
  end

  def deny_booking
    # booking_state = 2 means denied
    @booking.booking_state = 2
  end
end
