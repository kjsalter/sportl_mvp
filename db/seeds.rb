# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Booking.destroy_all
Sport.destroy_all
Player.destroy_all
Event.destroy_all

sports_list = [
  "american-football",
  "archery",
  "badminton",
  "baseball",
  "basketball",
  "bowling",
  "boxing",
  "chess",
  "cricket",
  "curling",
  "cycling",
  "darts",
  "football",
  "golf",
  "hockey",
  "ice-hockey",
  "ice-skating",
  "karate",
  "kayaking",
  "lacrosse",
  "netball",
  "roller-skating",
  "rounders",
  "rowing",
  "rugby",
  "sailing",
  "skate-boarding",
  "surfing",
  "table-tennis",
  "tennis",
  "ultimate-frisbee",
  "volleyball",
  "waterpolo",
]

postcodes= ['E1','E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9', 'E10','E11','E12','E13','E14','E15','E16','E17','E18','E20','EC1','EC2','EC3','EC4','N','N2', 'N3', 'N4', 'N5', 'N6', 'N7', 'N8', 'N9', 'N10','N11','N12','N13','N14','N15','N16','N17','N18','N19','N20','N21','N22','NW1', 'NW2', 'NW3', 'NW4', 'NW5', 'NW6', 'NW7', 'NW8', 'NW9', 'NW10','NW11','SE',  'SE1', 'SE2', 'SE3', 'SE4', 'SE5', 'SE6', 'SE7', 'SE8', 'SE9', 'SE10','SE11','SE12','SE13','SE14','SE15','SE16','SE17','SE18','SE19','SE20','SE21','SE22','SE23','SE24','SE25','SE26','SE27','SE28','SW1', 'SW2', 'SW3', 'SW4', 'SW5', 'SW6', 'SW7', 'SW8', 'SW9', 'SW10','SW11','SW12','SW13','SW14','SW15','SW16','SW17','SW18','SW19','SW20','W',  'W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7', 'W8', 'W9', 'W10', 'W11', 'W12', 'W13', 'W14', 'WC',  'WC2']


sports_list.each do |s|
  Sport.create!(name: s)
end

5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
  10.times do
    start_seed = Faker::Time.between(DateTime.now, DateTime.now + 5)
    event = Event.create!(
      sport: Sport.all.sample,
      title: Faker::Team.creature,
      gender: ["mens", "ladies", "mixed"].sample,
      city: "London",
      postcode: postcodes.sample,
      start_time: start_seed,
      end_time: start_seed + 1.hour,
      description: Faker::ChuckNorris.fact,
      level: (1..3).to_a.sample,
      missing_player: (1..5).to_a.sample,
      user: user
    )
  end
end


