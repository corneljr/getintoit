# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_sport do
    player_id 1
    sport_id 1
    deleted false
    position "MyString"
    skill_level 1
    comments "MyText"
  end
end
