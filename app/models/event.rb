class Event < ApplicationRecord
  belongs_to :user
  belongs_to :sport
  has_many :bookings
  validates :missing_player, presence: true
  geocoded_by :postcode
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.g_city = geo.city
      obj.g_postcode = geo.postal_code
      obj.g_country = geo.country_code
      obj.g_address = geo.address
    end
  end
  after_validation :geocode, :reverse_geocode, if: :postcode_changed?


  def self.search_event(sport, start_date, end_date, party_size, location, radius)

    #search by sports
    if sport == "All sports"
      search_by_sports = []
      Event.all.each { |event| event.active? ? search_by_sports << event : 5}
    else
      sports = Sport.where(name: sport)
      search_prelim = Event.where(sport: sports)
      search_by_sports = []
      search_prelim.each {|event| event.active? ? search_by_sports << event : 5}
    end

    #search by dates

    if (start_date.nil? || end_date.nil?)
      search_by_sports_dates = search_by_sports
    else
      unless (start_date.empty? || end_date.empty?) ||
        search_by_sports_dates = []
        search_by_sports.each { |event| event.dates?(start_date, end_date) ? search_by_sports_dates << event : 5}
      else
        search_by_sports_dates = search_by_sports
      end
    end

    if party_size == "Party size"
      search_by_sports_dates_party = []
      search_by_sports_dates.each {|event| event.available? ? search_by_sports_dates_party << event : 5 }
    else
      search_by_sports_dates_party = []
      search_by_sports_dates.each { |event| party_size.to_i <= event.missing_player ? search_by_sports_dates_party << event : 5 }
    end

    if (location.nil? || radius.nil?)
      search_by_sports_dates_party_location = search_by_sports_dates_party
    else
      unless location.empty? || radius.empty?
        search_by_sports_dates_party_location = []
        Event.near(location, radius).each do |event|
          search_by_sports_dates_party_location << event if search_by_sports_dates_party.include?(event)
        end
      else
        search_by_sports_dates_party_location = search_by_sports_dates_party
      end
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

  def active?
    self.active
  end

  def distance_from(searcher_coords)
    Geocoder::Calculations.distance_between([self.latitude, self.longitude], searcher_coords)
  end

  def self.distance_from_sorted(searcher_coords)
    all.sort_by { |e| e.distance_from(searcher_coords) }
  end
end




