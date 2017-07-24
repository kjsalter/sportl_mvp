# validates :missing_player, :sport, :title, :postcode, :start_time, :end_time, :level, presence: true
# validates :level, inclusion: { in: [1,2,3], allow_nil: false }
# validates :gender, presence: true

require "rails_helper"

RSpec.describe Event, :type => :model do

  it "is invalid when title is not present" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      missing_player: 2,
      sport: sport,
      postcode: "E1 6BT",
      start_time: DateTime.new(2017, 9, 30, 13),
      end_time: DateTime.new(2017, 9, 30, 15),
      level: 1,
      gender: "mens"
      )

    expect(invalid_event).not_to be_valid
  end

  it "is invalid when missing_player is not present" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      title: "FunEventTitle",
      sport: sport,
      postcode: "E1 6BT",
      start_time: DateTime.new(2017, 9, 30, 13),
      end_time: DateTime.new(2017, 9, 30, 15),
      level: 1,
      gender: "mens"
      )

    expect(invalid_event).not_to be_valid
  end

  it "is invalid when sport_id is not present" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      title: "FunEventTitle",
      missing_player: 2,
      postcode: "E1 6BT",
      start_time: DateTime.new(2017, 9, 30, 13),
      end_time: DateTime.new(2017, 9, 30, 15),
      level: 1,
      gender: "mens"
      )

    expect(invalid_event).not_to be_valid
  end

  it "is invalid when postocde is not present" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      title: "FunEventTitle",
      missing_player: 2,
      sport: sport,
      start_time: DateTime.new(2017, 9, 30, 13),
      end_time: DateTime.new(2017, 9, 30, 15),
      level: 1,
      gender: "mens"
      )

    expect(invalid_event).not_to be_valid
  end

  it "is invalid when start_time is not present" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      title: "FunEventTitle",
      missing_player: 2,
      sport: sport,
      postcode: "E1 6BT",
      end_time: DateTime.new(2017, 9, 30, 15),
      level: 1,
      gender: "mens"
      )

    expect(invalid_event).not_to be_valid
  end

  it "is invalid when end_time is not present" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      title: "FunEventTitle",
      missing_player: 2,
      sport: sport,
      postcode: "E1 6BT",
      start_time: DateTime.new(2017, 9, 30, 13),
      level: 1,
      gender: "mens"
      )

    expect(invalid_event).not_to be_valid
  end

  it "is invalid when level is not present" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      title: "FunEventTitle",
      missing_player: 2,
      sport: sport,
      postcode: "E1 6BT",
      start_time: DateTime.new(2017, 9, 30, 13),
      end_time: DateTime.new(2017, 9, 30, 15),
      gender: "mens"
      )

    expect(invalid_event).not_to be_valid
  end

  it "is invalid when gender is not present" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      title: "FunEventTitle",
      missing_player: 2,
      sport: sport,
      postcode: "E1 6BT",
      start_time: DateTime.new(2017, 9, 30, 13),
      end_time: DateTime.new(2017, 9, 30, 15),
      level: 1
      )

    expect(invalid_event).not_to be_valid
  end

  it "is invalid when level is less than 1" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      title: "FunEventTitle",
      missing_player: 2,
      sport: sport,
      postcode: "E1 6BT",
      start_time: DateTime.new(2017, 9, 30, 13),
      end_time: DateTime.new(2017, 9, 30, 15),
      level: 0,
      gender: "mens"
      )

    expect(invalid_event).not_to be_valid
  end

  it "is invalid when level is greater than 3" do
    sport = Sport.new(name: "Football")

    invalid_event = Event.new(
      title: "FunEventTitle",
      missing_player: 2,
      sport: sport,
      postcode: "E1 6BT",
      start_time: DateTime.new(2017, 9, 30, 13),
      end_time: DateTime.new(2017, 9, 30, 15),
      level: 4,
      gender: "mens"
      )

    expect(invalid_event).not_to be_valid
  end

  it "is valid when title, missing_player, sport_id, postocde, start_time, end_time, level and gender are present and when level is equal to 1, 2 or 3" do
    sport = Sport.new(name: "Football")

    valid_event = Event.new(
      title: "FunEventTitle",
      missing_player: 2,
      sport: sport,
      postcode: "E1 6BT",
      start_time: DateTime.new(2017, 9, 30, 13),
      end_time: DateTime.new(2017, 9, 30, 15),
      level: [1,2,3].sample,
      gender: "mens"
      )

    expect(valid_event).to be_valid
  end
end
