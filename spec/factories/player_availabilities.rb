# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_availability do
    player_id 1
    day 1
    available_from "2014-08-17 19:00:00"
    available_to "2014-08-17 19:00:00"
  end
end
