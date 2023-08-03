# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'

puts "--- clearing database ---"
Pallet.destroy_all
Scan.destroy_all
Shipment.destroy_all
Project.destroy_all
User.destroy_all

puts "--- creating projects ---"
Project.create(name: "Ukraine")
Project.create(name: "Sierra Leone")
Project.create(name: "Northern Iraq")
Project.create(name: "Syria")
Project.create(name: "Afghanistan")

puts "--- creating default users ---"
User.create(first_name: "Vincent", last_name: "Stuber", email: "vincent@stuber.com", password: "123456")
# p u.errors.full_messages
User.create(first_name: "Sophie", last_name: "Sorin", email: "sophie@sorin.com", password: "123456")
User.create(first_name: "Maria", last_name: "Pigazzi", email: "maria@pigazzi.com", password: "123456")
User.create(first_name: "Finn", last_name: "Stürenburg", email: "finn@stuerenburg.com", password: "123456", admin: true)
User.create(first_name: "Dr. Malik", last_name: "Weber", email: "dr.malik@weber.com", password: "123456", user_type: 0)
User.create(first_name: "Mitzy-Gertrud", last_name: "Von Knapfen", email: "mitzy@gertrud.com", password: "123456", user_type: 0)
User.create(first_name: "Snoop", last_name: "Paca III", email: "snoop@paca.com", password: "123456", user_type: 0)

puts "--- creating shipments ---"
10.times do
  a = Shipment.new
  a.user = User.aidpioneer.sample
  a.project = Project.find_by(name: "Ukraine")
  a.start_date = Date.new(2022,3,9) + rand(0..75)
  a.expected_arrival_date = a.start_date + rand(3..6)
  a.transport_type = 0
  a.starting_location = "Berlin"
  a.destination_location = ["Lviv", "Rivne", "Ivano-Frankivsk", "Ternopil"].sample
  a.qr_code_type = rand(0..1)
  a.status = rand(0..3)
  a.save
  p a.errors.full_messages
end


puts "--- creating pallets ---"
20.times do
  pal = Pallet.new
  pal.donor = User.donor.sample
  pal.shipment = Shipment.all.sample
  pal.content = ["Food", "Medicine", "Hygiene", "Clothes"].sample # not sure here how it can match the category below
  pal.content_category = ["Food", "Medicine", "Hygiene", "Clothes"].sample
  pal.save
  p pal.errors.full_messages
end


puts "--- creating scans ---"
40.times do
  s = Scan.new
  s.shipment = Shipment.all.sample
  s.date = s.shipment.start_date + rand(0..4).days + rand(0..12).hours + + rand(0..60).minutes
  s.location = ["Berlin", "Warsaw", "Border Poland", "Lviv", "Rivne", "Ivano-Frankivsk", "Ternopil"].sample # does it get scanned anywhere between between Berlin and the POL/UKR border?
  s.sticker_destroyed = 0 # just leaving it false for now
  s.save
  p s.errors.full_messages
end
