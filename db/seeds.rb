# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Sport.destroy_all

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
  "skateboarding",
  "surfing",
  "table-tennis",
  "tennis",
  "ultimate-frisbee",
  "volleyball",
  "waterpolo",
]

sports_list.each do |s|
  Sport.create(name: s)
end
