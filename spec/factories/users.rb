FactoryBot.define do
  factory :user do
    name { FFaker::Internet.user_name }
    phone { FFaker::PhoneNumber.short_phone_number }
    city_id nil
  end
end