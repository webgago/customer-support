FactoryGirl.define do
  factory :reply do
    body { Faker::Lorem.paragraph }
    ticket
    user factory: :support_agent
  end
end
