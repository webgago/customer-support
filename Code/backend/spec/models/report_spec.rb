require 'rails_helper'

describe Report, freeze: true do
  subject { described_class.new }

  def import!(*tickets)
    TicketsIndex::Ticket.import! tickets.flatten
  end

  describe '#threshold' do
    specify { expect(subject.threshold).to eql(2.days) }
  end

  describe '#status' do
    specify { expect(subject.status).to eql(Ticket::STATUS.closed) }
  end

  describe '#period' do
    specify { expect(subject.period).to match_array([1.month.ago.beginning_of_day, Time.current]) }
  end

  describe '#data' do
    let!(:sample_tickets) { [target_tickets, create_list(:ticket, 3)].flatten }
    let!(:target_tickets) { create_list :ticket, 2, :closed, closed_at: 2.weeks.ago }
    before { import! sample_tickets }

    specify { expect(subject.data).to match_array(target_tickets) }
  end
end
