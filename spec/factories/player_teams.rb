# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_team do
    player_id 1
    league_id 1
    team_id 1
    deleted false
  end
end
