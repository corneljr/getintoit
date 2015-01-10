# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :zip_code do
    zip_scf_id 1
    zip_code 1
    latitude "9.99"
    longitude "9.99"
    city_id 1
    state_id 1
  end
end
