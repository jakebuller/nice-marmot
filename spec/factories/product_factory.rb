require 'factory_girl'

FactoryGirl.define do
  factory :product do
    id 1
    name 'abc123'
    description 'test description'
    price 1500
    available true
    purchase_link 'http://www.exmaple.com'
    image_link 'http://www.exmaple.com'
  end
end
