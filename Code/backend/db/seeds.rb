# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'factory_girl'
require 'faker'
require 'database_cleaner'

FactoryGirl.reload
include ::FactoryGirl::Syntax::Methods
Faker::Config.locale = 'en-US'
DatabaseCleaner.clean_with :truncation
Chewy.massacre

def rand_closed_at
  rand(1..30).days.ago
end

def rand_created_at
  rand(1..30).days.ago
end

Chewy.strategy(:atomic) do
  create :admin, email: 'admin@example.com'
  create :support_agent
  create :customer, first_name: 'Test #1'
  create :customer, first_name: 'Test #2'
  create :customer, first_name: 'Test #3'

  customers = create_list :customer, 3
  customers.each do |customer|
    20.times do
      create :ticket, user: customer, created_at: rand_created_at, updated_at: rand_created_at
    end
    10.times do
      create :ticket, status: Ticket::STATUS.closed,
        user: customer,
        created_at: rand_created_at,
        updated_at: rand_created_at,
        closed_at: rand_closed_at
    end
  end
end
