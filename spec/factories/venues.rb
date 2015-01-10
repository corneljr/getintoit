# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    country 1
    city_id 1
    province_id 1
    address "MyString"
    notes "MyText"
  end
end
