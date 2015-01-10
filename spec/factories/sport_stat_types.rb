# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sport_stat_type, :class => 'Sport::StatType' do
    name "MyString"
  end
end
