# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    league_id 1
    name "MyString"
    num_players 1
    deleted false
  end
end
