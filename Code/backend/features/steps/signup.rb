class Spinach::Features::SignUp < Spinach::FeatureSteps
  before do
    Timecop.freeze Time.current.change(sec: 0)
  end

  after do
    Timecop.return
  end

  When 'I signed up previously' do
    create(:customer, signup_params)
  end

  When 'I sign up as a customer' do
    post '/signup', signup_params
  end

  Then 'I can access application' do
    expect(last_customer.email).to eql(customer_email)
    expect(last_customer.first_name).to eql(first_name)
    expect(last_customer.last_name).to eql(last_name)
  end

  Then 'I get "user is already signed up" error' do
    expect(parsed_body.dig(:errors, :email)).to eql ['has already been taken']
  end

  private

  def last_customer
    User.last
  end

  def signup_params
    {
      email: customer_email,
      password: '12345678',
      first_name: first_name,
      last_name: last_name
    }
  end

  def first_name
    @first_name ||= Faker::Name.first_name
  end

  def last_name
    @last_name ||= Faker::Name.last_name
  end

  def customer_email
    'testcustomer@example.com'
  end
end
