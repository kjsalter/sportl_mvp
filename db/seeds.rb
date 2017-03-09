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

pre_sport_title = ['WE KNOW YOU WANT TO PLAY ', 'Drunk game of ', 'Spicy night of ', 'Burn that belly with a game of ', 'Fabulous session of ', 'Players DESPERATELY needed for ', 'Weekly & Cheeky ']
post_sport_title = [". No Republicans!", ". Bonus points if you're fluent in Latin.", '. This is a paid gig.', '. Beers (Tequila) after.', '. Competition format.', '. Long-term Coach wanted.']
descs =  ["Group of friends having a blast. We make up for our naivety regarding the basic rules with our athletic prowess. Note: We all work office jobs and this is our sole bout of exercise each week.", "'The best defence is a good offence' ~ Katie Salter. Unfortunately, our two attackers broke their necks last week - so you're our only option. To be explicit, it was taking part in a similar event to this one.", "Life getting you down? Fear not. Embrace your natural high to the beat of classics such as 'Don't stop believing', the 'Macarena', and 'Ice Ice Baby'.", "Come with your game face on & let's make some magic. P.S we dress all in black to intimidate the opposition. P.P.S We perform a Haka; if you want to learn the dance come 20 minutes early, otherwise screaming and shouting will suffice.", "Do you ever feel something missing in your life? Congratulations, you've stumbled upon it. I know what you're thinking, and you're right. It's Sportl. Sportl is the best designed website I have ever encountered. I credit it with saving my marriage, fixing my broken leg and Ed Sheeran's new album." ]

start_seed = Faker::Time.between(DateTime.now, DateTime.now + 5)

5.times do
  user = User.create(
    email: Faker::Internet.email,
    password: "passWord123",
    username: Faker::Internet.user_name,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: postcodes.sample,
    bio: Faker::Company.catch_phrase,
    gender: ["Male", "Female", "Other"].sample
    )
  3.times do
    sport_item = Sport.all.sample
    event = Event.create(
      sport: sport_item,
      title: pre_sport_title.sample + sport_item.name + post_sport_title.sample,
      gender: ["mens", "ladies", "mixed"].sample,
      city: "London",
      postcode: postcodes.sample,
      start_time: start_seed,
      end_time: start_seed + 1.hour,
      description: descs.sample,
      level: (1..3).to_a.sample,
      missing_player: (1..5).to_a.sample,
      user: user
      )
  end

end

# 5.times do
#   user = User.create!(
#     email: Faker::Internet.email,
#     password: Faker::Internet.password(8)
#   )
#   10.times do
#     start_seed = Faker::Time.between(DateTime.now, DateTime.now + 5)
#     event = Event.create!(
#       sport: Sport.all.sample,
#       title: Faker::Team.creature,
#       gender: ["mens", "ladies", "mixed"].sample,
#       city: "London",
#       postcode: postcodes.sample,
#       start_time: start_seed,
#       end_time: start_seed + 1.hour,
#       description: Faker::ChuckNorris.fact,
#       level: (1..3).to_a.sample,
#       missing_player: (1..5).to_a.sample,
#       user: user
#     )
#   end
# end


