module Common
  module ErrorSteps
    include Spinach::DSL

    Given 'I am a customer' do
      @user = create :customer
    end

    Given 'I am a support agent' do
      @user = create :support_agent
    end
  end
end
