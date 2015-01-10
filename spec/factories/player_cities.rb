# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_city do
    player_id 1
    city_id 1
    deleted false
  end
end
