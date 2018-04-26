class Review < ApplicationRecord
    belong_to :user
    belong_to :reviewable, polymorphic: true
end
