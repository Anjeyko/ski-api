class User < ApplicationRecord
  belongs_to :city
  has_many :items
  has_many :bookings
  has_many :reviews, as: :reviewable
  has_many :authored_reviews, foreign_key: :user_id, class_name: 'Review'
  has_many :items_reviews, through: :items, source: :reviews
end
