class Spinach::Features::DestroyUsers < Spinach::FeatureSteps
  When 'I destroy a user' do
    delete user_url(user.id)
  end

  Then 'user has been destroyed' do
    expect(User.find_by(id: user.id)).to be_nil
  end

  private

  def user
    @user ||= create(:customer)
  end

  def schema
    'users'
  end
end
