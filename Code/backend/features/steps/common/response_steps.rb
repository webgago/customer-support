module Common
  module ResponseSteps
    include Spinach::DSL

    Then 'response is 200 Ok' do
      expect(http_status).to eql 200
      expect(parsed_body).to match_schema schema
    end

    Then 'response is 201 Created' do
      expect(http_status).to eql 201
    end

    Then 'response is 204 No Content' do
      expect(http_status).to eql 204
      expect(json_body).to be_empty
    end

    And 'result is paginated' do
      expect(headers.to_json).to match_schema 'pagination_header'
    end

    def result_count
      parsed_body.count
    end
  end
end
