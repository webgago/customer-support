class Spinach::Features::Authentication < Spinach::FeatureSteps
  before do
    Timecop.freeze Time.current.change(sec: 0)
  end

  after do
    Timecop.return
  end

  Given "I'm a customer" do
    @user ||= create(:customer)
  end

  Given "I'm a support agent" do
    @user ||= create(:support_agent)
  end

  When 'I sign in by email' do
    post '/login', auth_email_params(@user.email, @user.password)
  end

  When 'I sign in with wrong email' do
    post '/login', auth_email_params('not-a-user@example.com', 'password')
  end

  Then 'I get the access token' do
    expect(json_body).to eql json_encode(jwt: @user.jwt_token)
    expect(payload).to include 'sub' => @user.id
    expect(payload).to include 'exp' => 1.day.from_now.to_i
    expect(payload).to include 'email' => @user.email
    expect(payload).to include 'first_name' => @user.first_name
    expect(payload).to include 'last_name' => @user.last_name
  end

  private

  def auth_email_params(email, password)
    {
      email: email,
      password: password
    }
  end

  def payload
    @payload ||= Knock::AuthToken.new(token: parsed_body[:jwt]).payload
  end
end
