# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    country 1
    name "MyString"
    latitude "9.99"
    longitude "9.99"
  end
end
