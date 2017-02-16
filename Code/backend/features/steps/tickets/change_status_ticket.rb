class Spinach::Features::ChangeStatusTicket < Spinach::FeatureSteps
  When 'I close a ticket' do
    put close_ticket_url(ticket)
  end

  When 'I reopen closed ticket' do
    put reopen_ticket_url(closed_ticket)
  end

  Then 'ticket is closed' do
    expect(ticket.reload.status).to eql(Ticket::STATUS.closed)
  end

  Then 'ticket is open' do
    expect(ticket.reload.status).to eql(Ticket::STATUS.open)
  end

  private

  def schema
    'ticket'
  end

  def ticket
    @ticket ||= create(:ticket)
  end

  def closed_ticket
    @ticket ||= create(:ticket, :closed)
  end
end
