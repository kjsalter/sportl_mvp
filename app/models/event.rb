class Event < ApplicationRecord
  belongs_to :user
  belongs_to :sport

  geocoded_by :postcode
  after_validation :geocode, if: :postcode_changed?
end
