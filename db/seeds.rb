# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times {User.create!(name: Faker::Name.name, email: Faker::Internet.email, password:"123456")}

70.times {Listing.create!(
    title: Faker::Address.street_name, 
    description: Faker::Lorem.paragraph, 
    pax: rand(1..4), 
    country: Faker::Address.country, 
    address: Faker::Address.city, 
    user_id: rand(1..20))}