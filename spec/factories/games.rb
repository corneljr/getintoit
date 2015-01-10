# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    sport_id 1
    league_id 1
    city_id 1
    venue_id 1
    team1_id 1
    team2_id 1
    player1_id 1
    player2_id 1
    starts_at "2014-08-17 18:55:35"
    finishes_at "2014-08-17 18:55:35"
    score1 1
    score2 1
  end
end
