require 'rails_helper'

describe TicketManager, freeze: true do
  subject { described_class.new(create(:customer)) }

  describe '#create' do
    it 'creates ticket for current user' do
      expect { subject.create('title', 'body') }.to change(Ticket, :count).by(1)
    end

    it 'sets ticket status to new' do
      expect(subject.create('title', 'body').status).to eql('new')
    end

    context 'when title is empty' do
      it 'raises error ActiveRecord::RecordInvalid' do
        expect { subject.create('', 'body') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when body is empty' do
      it 'raises error ActiveRecord::RecordInvalid' do
        expect { subject.create('title', '') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#reply' do
    let!(:ticket) { create(:ticket) }

    it 'creates Reply for the ticket' do
      expect { subject.reply(ticket, 'reply body', Ticket::STATUS.open) }.to change(ticket.replies, :count).by(1)
    end

    it 'sets status of the ticket' do
      expect { subject.reply(ticket, 'reply body', Ticket::STATUS.closed) }
        .to change { ticket.reload.status }.to(Ticket::STATUS.closed)
    end

    context 'when reply body is empty' do
      it 'raises error ActiveRecord::RecordInvalid' do
        expect { subject.reply(ticket, '', Ticket::STATUS.open) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#reopen' do
    let!(:ticket) { create(:ticket) }

    it 'sets status of the ticket' do
      expect { subject.reopen(ticket) }.to change { ticket.reload.status }.to(Ticket::STATUS.open)
    end
  end

  describe '#close' do
    let!(:ticket) { create(:ticket) }

    it 'sets status of the ticket' do
      expect { subject.close(ticket) }.to change { ticket.reload.status }.to(Ticket::STATUS.closed)
    end

    it 'sets closed_at' do
      expect { subject.close(ticket) }.to change { ticket.reload.closed_at }.to(Time.current)
    end
  end
end
