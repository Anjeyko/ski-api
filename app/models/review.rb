class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validate :review_validation, on: :create

  def review_validation
    if reviewable_type == 'User'
      unless Booking.joins(:item).where('items.user_id' => reviewable_id, 'bookings.user_id' => user_id).or(Booking.joins(:item).where('bookings.user_id' => reviewable_id, 'items.user_id' => user_id)).exists?
        add_error(:review, "Error: you never dealt with this user")
      end
    elsif reviewable_type == 'Item'
      unless user.bookings.where(item_id: reviewable_id).exists?
        add_error(:review, "Error:you never booked this item")
      end
    end
  end
end
