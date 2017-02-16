class Spinach::Features::ReplyToTicket < Spinach::FeatureSteps
  When 'I reply to ticket' do
    post reply_ticket_url(ticket), params
  end

  When 'I reply to ticket with status "closed"' do
    post reply_ticket_url(ticket), params_with_status
  end

  When 'I create ticket with invalid params' do
    post reply_ticket_url(ticket), invalid_params
  end

  Then 'Ticket is closed' do
    expect(ticket.reload.status).to eql 'closed'
  end

  private

  def ticket
    @ticket ||= create(:ticket)
  end

  def schema
    'ticket'
  end

  def params
    {
      reply: Faker::Lorem.paragraph
    }
  end

  def params_with_status
    params.update(status: 'closed')
  end

  def invalid_params
    {}
  end
end
