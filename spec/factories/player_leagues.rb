# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_league do
    player_id 1
    league_id 1
    deleted false
  end
end
