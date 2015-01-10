# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_game do
    league_id 1
    player_id 1
    team_id 1
    game_id 1
    subbed false
  end
end
