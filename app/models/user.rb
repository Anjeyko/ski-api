class User < ApplicationRecord
  has_many :items
  has_many :bookings
  has_many :reviews, as: :reviewable
  has_many :authored_reviews, foreign_key: :user_id, class_name: 'Rewiew'
end
