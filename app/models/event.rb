class Event < ApplicationRecord
  belongs_to :user
  belongs_to :sport
  has_many :bookings
  geocoded_by :postcode
  after_validation :geocode, if: :postcode_changed?
  searchkick

  def self.search_event(sport, start_date, end_date, location, radius)

    #search by sports
    if sport == "All sports"
      search_by_sports = Event.all
    else
      sports = Sport.where(name: sport)
      search_by_sports = Event.where(sport: sports)
    end

    #search by dates
    unless start_date.empty? || end_date.empty?
      search_by_sports_dates = []
      search_by_sports.each { |event| event.dates?(start_date, end_date) ? search_by_sports_dates << event : 5}
    else
      search_by_sports_dates = search_by_sports
    end
    #   # Location

    unless location.empty? || radius.empty?
      search_by_sports_dates_location = []
      Event.near(location, radius).each do |event|
        search_by_sports_dates_location << event if search_by_sports_dates.include?(event)
      end
    else
      search_by_sports_dates_location = search_by_sports_dates
    end

    return search_by_sports_dates_location
  end

  def dates?(start_date, end_date)
    ((start_date <= self.start) && (self.start <= end_date)) && ((start_date <= self.end) && (self.end <= end_date))
  end

end




