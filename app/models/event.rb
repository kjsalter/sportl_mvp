class Event < ApplicationRecord
  belongs_to :user
  belongs_to :sport
  has_many :bookings
  geocoded_by :postcode
  validates :missing_player, presence: true
  after_validation :geocode, if: :postcode_changed?

  def self.search_event(sport, start_date, end_date, party_size, location, radius)

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

    if party_size == "Party size"
      search_by_sports_dates_party = []
      search_by_sports_dates.each {|event| event.available? ? search_by_sports_dates_party << event : 5 }
    else
      search_by_sports_dates_party = []
      search_by_sports_dates.each { |event| party_size.to_i <= event.missing_player ? search_by_sports_dates_party << event : 5 }
    end

    unless location.empty? || radius.empty?
      search_by_sports_dates_party_location = []
      Event.near(location, radius).each do |event|
        search_by_sports_dates_party_location << event if search_by_sports_dates_party.include?(event)
      end
    else
      search_by_sports_dates_party_location = search_by_sports_dates_party
    end

    return search_by_sports_dates_party_location
  end

  def dates?(start_date, end_date)
    ((start_date <= self.start) && (self.start <= end_date)) && ((start_date <= self.end) && (self.end <= end_date))
  end

  def available?
    self.missing_player > 0
  end

  def update_players
    self.bookings.each { |booking| self.missing_player -= booking.no_players}
    self.save
  end

end




