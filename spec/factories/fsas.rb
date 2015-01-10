# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fsa do
    label "MyString"
    latitude "9.99"
    longitude "9.99"
    city_id 1
    province_id 1
  end
end
