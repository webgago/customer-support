ENV['RAILS_ENV'] = 'test'
# simplecov for code coverage
require 'simplecov'
SimpleCov.start :rails do
end

require './config/environment'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('features/steps/common/**/*.rb')].each { |f| require f }

require 'rack/test'
# database cleaner
require 'database_cleaner'
require 'email_spec'
require 'email_spec/rspec'
require 'fileutils'

DatabaseCleaner.strategy = :truncation
Faker::Config.locale = 'en-US'
Spinach.hooks.before_run do
  FileUtils.mkpath(Rails.root.join('tmp/captures'))
  FileUtils.rm_rf(Rails.root.join('tmp/captures/*'))
end

Spinach.hooks.before_scenario do
  DatabaseCleaner.clean
  Chewy.massacre
  Chewy.strategy(:urgent)
end

Spinach.hooks.after_scenario do |scenario, env|
  next unless scenario.tags.include? 'debug'
  capture_base_path = Rails.root.join('tmp/captures')
  raw_body = env.last_response.body
  path = URI.parse(env.last_request.url).path
  file_name = "#{path.parameterize}.json"
  parsed_body = JSON.parse(raw_body)
  JSON.pretty_generate(parsed_body).tap do |pretty_json|
    File.write(File.join(capture_base_path, file_name), pretty_json)
  end
end

class Spinach::FeatureSteps
  include Rack::Test::Methods
  include ::FactoryGirl::Syntax::Methods
  include Rails.application.routes.url_helpers
  include Common::Helper
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  include RSpec::Matchers
end

ActiveRecord::Migration.maintain_test_schema!
