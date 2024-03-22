# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# clear the dabase
Dayslot.delete_all
Review.delete_all
Message.delete_all
Chatroom.delete_all
Booking.delete_all
Service.delete_all
User.delete_all

puts "adding users"
user1 = User.create!(email: "peter@gmail.com", first_name: "Peter", last_name: "Parker", password: "123456", password_confirmation: "123456", provider: true, phone: "+44 20 7946 0018", start_hour: 9, end_hour: 17, start_date: Date.new(2024, 3, 25), end_date: Date.new(2024, 4, 5))
user2 = User.create!(email: "jane@gmail.com", first_name: "Jane", last_name: "Austen", password: "123456", password_confirmation: "123456", provider: true, phone: "+49 173 4234 8349", start_hour: 10, end_hour: 16, start_date: Date.new(2024, 3, 25), end_date: Date.new(2024, 4, 5))
user3 = User.create!(email: "donald@gmail.com", first_name: "Donald", last_name: "Trump", password: "123456", password_confirmation: "123456", provider: true, phone: "+1 415 723 1492", start_hour: 13, end_hour: 16, start_date: Date.new(2024, 3, 25), end_date: Date.new(2024, 4, 5))


puts "adding services"
service1 = Service.create!(user: user1, price: 50, name: "Haircut", address: "10 Downing Street, London")
service2 = Service.create!(user: user1, price: 100, name: "Tattoo", address: "10 Downing Street, London")
service3 = Service.create!(user: user2, price: 150, name: "Literary Brain Massage", address: "12 Ackerstrasse, Berlin")
service4 = Service.create!(user: user3, price: 12000, name: "Orange Hair Conditioning", address: "White House, Washington D.C.")

puts "adding bookings"
booking1 = Booking.create!(user: user2, service: service1, date: Date.new(2024, 3, 23), start_hour: 10)
booking2 = Booking.create!(user: user2, service: service2, date: Date.new(2024, 3, 23), start_hour: 11)
booking3 = Booking.create!(user: user3, service: service3, date: Date.new(2024, 3, 24), start_hour: 14)
booking4 = Booking.create!(user: user1, service: service4, date: Date.new(2024, 3, 22), start_hour: 13)

puts "adding reviews"
review1 = Review.create!(booking: booking1, rating: 4.9, comment: "amaze")
review2 = Review.create!(booking: booking2, rating: 5.0, comment: "perfection")
review3 = Review.create!(booking: booking3, rating: 5.0, comment: "The massage slapped the literacy back into me, and I can finally speak English now! (#Trump)")
review4 = Review.create!(booking: booking4, rating: 5.0, comment: "The most luxurious orange hair conditioning service you can get out there, I can really feel my orange glow!")

puts "done"
