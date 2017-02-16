FactoryGirl.define do
  factory :ticket do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    user factory: :customer
    status { Ticket::STATUS.new }

    trait :closed do
      status Ticket::STATUS.closed
    end

    trait :hipster do
      title { Faker::Hipster.sentence }
      body { Faker::Hipster.paragraph }
    end
  end
end
