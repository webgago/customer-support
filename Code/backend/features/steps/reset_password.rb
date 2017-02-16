class Spinach::Features::ResetPassword < Spinach::FeatureSteps
  When 'I request to reset password' do
    post '/password', email: @user.try(:email) || customer_email
  end

  Then 'I get reset password instructions via email' do
    expect(links_in_email(last_email_sent)).to include reset_password_url
  end

  When 'I set new password' do
    put password_url(reset_password_token: @user.reload.reset_password_token, password: 'newpassword')
  end

  Then 'I can sign in using this password' do
    sign_in(@user.email, 'newpassword')
    expect(http_status).to eql 201
  end

  private

  def sign_in(email, password)
    post '/login', email: email, password: password
  end

  def reset_password_url
    password_url(token: @user.reload.reset_password_token)
  end

  def customer_email
    'testcustomer@example.com'
  end
end
