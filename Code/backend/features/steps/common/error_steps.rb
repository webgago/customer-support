module Common
  module ErrorSteps
    include Spinach::DSL

    Then 'I get 422 error' do
      assert_error(422)
    end

    Then 'I get 404 error' do
      assert_error(404)
    end

    Then 'I get 401 error' do
      assert_error(401)
    end

    Then 'I get 403 error' do
      assert_error(403)
    end

    def assert_error(status)
      expect(http_status).to eql status
      expect(parsed_body).to match_schema 'errors'
    end
  end
end
