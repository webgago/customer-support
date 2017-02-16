class Spinach::Features::ListUsers < Spinach::FeatureSteps
  When 'I get the list of users' do
    get users_url
  end

  Then 'I view all requests' do
    expect(parsed_body.count).to eql 4
  end

  private

  def after_login
    create_list(:customer, 3)
  end

  def schema
    'users'
  end
end
