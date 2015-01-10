# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_stat, :class => 'Player::Stat' do
    sport_id 1
    league_id 1
    stat_type_id 1
    stat_type_value 1.5
  end
end
