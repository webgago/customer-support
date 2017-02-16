module Common
  module SignIn
    include Spinach::DSL

    Given "I'm logged in as a customer" do
      sign_in customer
    end

    Given "I'm logged in as a support agent" do
      sign_in support_agent
    end

    Given "I'm logged in as an admin" do
      sign_in admin
    end

    def current_user
      @current_user
    end

    def customer
      @customer ||= create(:customer)
    end

    def support_agent
      @support_agent ||= create(:support_agent)
    end

    def admin
      @admin ||= create(:admin)
    end

    def sign_in(user)
      post login_url, auth_params(user)
      raise ApplicationError unless jwt_token.present?
      @current_user = user
      set_auth_header
      after_login
    end

    def auth_params(user)
      {
        email: user.email,
        password: user.password
      }
    end

    def set_auth_header
      header 'Authorization', "Bearer #{jwt_token}"
    end

    def jwt_token
      parsed_body[:jwt]
    end

    def after_login
    end
  end
end
