# clear the dabase
Review.delete_all
Booking.delete_all
Service.delete_all
User.delete_all
puts "adding users"
user1 = User.create!(email: "peter@gmail.com", first_name: "Peter", last_name: "Parker", password: "123456", password_confirmation: "123456")
user2 = User.create!(email: "jane@gmail.com", first_name: "Jane", last_name: "Austen", password: "123456", password_confirmation: "123456")
puts "adding services"
service1 = Service.create!(user: user1, price: 50, name: "haircut", address: "10 Downing Street")
service2 = Service.create!(user: user1, price: 100, name: "tattoo", address: "10 Downing Street")
puts "adding bookings"
booking1 = Booking.create!(user: user2, service:service1, start_date_time: Time.current, end_date_time: 1.hour.from_now)
booking2 = Booking.create!(user: user2, service:service2, start_date_time: 2.hour.from_now, end_date_time: 3.hour.from_now)
puts "adding reviews"
review1 = Review.create!(booking: booking1, rating: 4.9, comment: "amaze")
review2 = Review.create!(booking: booking2, rating: 5.0, comment: "perfection")
puts "done"
