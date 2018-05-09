
FactoryBot.define do
  factory :item do
    name { FFaker::Product.product_name }
    user_id nil
  end
end