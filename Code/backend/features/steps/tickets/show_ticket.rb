class Spinach::Features::ShowTicket < Spinach::FeatureSteps
  When 'I get my ticket' do
    get ticket_url(my_ticket)
  end

  When 'I get wrong ticket' do
    get ticket_url(wrong_ticket)
  end

  When 'I get a ticket by id' do
    get ticket_url(wrong_ticket)
  end

  private

  def schema
    'ticket'
  end

  def my_ticket
    @ticket ||= create(:ticket, user: current_user)
  end

  def wrong_ticket
    @ticket ||= create(:ticket)
  end
end
