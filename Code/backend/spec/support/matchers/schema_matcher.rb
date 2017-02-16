require 'rspec'
require 'rspec/expectations'
require 'json-schema'

# Validates JSON responses against a schema
RSpec::Matchers.define :match_schema do |schema|
  match do |response_or_body|
    body =
      if response_or_body.is_a?(String)
        response_or_body
      else
        response_or_body.to_json
      end

    JSON::Validator.validate!(
      schema_path,
      body,
      validate_schema: true,
      strict: false
    )
  end

  define_method :schema_directory do
    "#{Dir.pwd}/spec/support/schemas"
  end

  define_method :schema_path do
    "#{schema_directory}/#{schema}.json"
  end

  define_method :schema_relative_path do
    "#{schema_directory}/#{schema}.json".sub(Dir.pwd, '')
  end

  description do
    "match the JSON schema '#{schema_relative_path}'"
  end
end
