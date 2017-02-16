class Spinach::Features::AddTicket < Spinach::FeatureSteps
  When 'I create ticket' do
    post tickets_url, params
  end

  When 'I create ticket with invalid params' do
    post tickets_url, invalid_params
  end

  private

  def schema
    'ticket'
  end

  def params
    {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph
    }
  end

  def invalid_params
    {}
  end
end
