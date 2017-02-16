class Spinach::Features::ListTickets < Spinach::FeatureSteps
  When 'I get the list of tickets' do
    get tickets_url
  end

  Then 'I view only my requests' do
    expect(parsed_body.count).to eql 5
  end

  Then 'I view all requests' do
    expect(parsed_body.count).to eql 8
  end

  private

  def after_login
    create_list :ticket, 3
    create_list :ticket, 5, user: current_user
  end

  def schema
    'tickets'
  end
end
