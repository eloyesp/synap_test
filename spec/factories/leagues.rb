FactoryBot.define do
  factory :league do
    name { "#{Faker::Name.last_name} Family League" }
  end
end
