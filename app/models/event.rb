class Event < ApplicationRecord
  belongs_to :user
  belongs_to :sport
  has_many :bookings

  geocoded_by :postcode
  after_validation :geocode, if: :postcode_changed?
end
