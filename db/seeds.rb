require 'ffaker'

# Cities
5.times do
  City.create(name: FFaker::Address.city)
end

# Users
20.times do
  User.create(
    name: FFaker::Internet.user_name,
    phone: FFaker::PhoneNumber.short_phone_number,
    city_id: rand(1..5)
  )
end
 
# Items
30.times do |n|
  Item.create(
    name: "Item##{n+1}",
    user_id: rand(1..20)
  )
end

# Bookings
10.times do
  Booking.create( 
   start_date: FFaker::Time.between(3.days.ago, Time.now),
    end_date: FFaker::Time.between(5.days.after, 10.days.after),
    user_id: rand(1..10),
    item_id: rand(1..20)
  )
 end