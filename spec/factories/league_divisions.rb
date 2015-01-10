# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :league_division do
    league_id 1
    name "MyString"
    num_teams 1
    num_players 1
  end
end
