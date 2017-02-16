require 'rails_helper'

describe TicketPolicy do
  subject { described_class }

  def ticket(attrs = {})
    Ticket.new(attrs)
  end

  def status
    Ticket::STATUS
  end

  permissions :index? do
    it 'grants access if customer' do
      expect(subject).to permit(User.new(role: 'customer'), ticket)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(role: User::ROLE.admin), ticket)
    end

    it 'grants access if user is a support agent' do
      expect(subject).to permit(User.new(role: User::ROLE.agent), ticket)
    end
  end

  permissions :unfiltered_search?, :reopen?, :close? do
    it 'denies access if customer' do
      expect(subject).not_to permit(User.new(role: 'customer'), ticket)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(role: User::ROLE.admin), ticket)
    end

    it 'grants access if user is a support agent' do
      expect(subject).to permit(User.new(role: User::ROLE.agent), ticket)
    end
  end

  permissions :show?, :update? do
    it 'denies access if user not the owner of the ticket' do
      expect(subject).not_to permit(User.new(role: 'customer', id: 1), ticket(user_id: 2))
    end

    it 'grants access if user the owner of the ticket' do
      expect(subject).to permit(User.new(role: 'customer', id: 1), ticket(user_id: 1))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(role: User::ROLE.admin), ticket)
    end

    it 'grants access if user is a support agent' do
      expect(subject).to permit(User.new(role: User::ROLE.agent), ticket)
    end
  end

  permissions :reply? do
    it 'denies access if user not the owner of the ticket' do
      expect(subject).not_to permit(User.new(role: 'customer', id: 1), ticket(user_id: 2, status: status.open))
    end

    it 'grants access if user the owner of the ticket' do
      expect(subject).to permit(User.new(role: 'customer', id: 1), ticket(user_id: 1, status: status.open))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(role: User::ROLE.admin), ticket(status: status.open))
    end

    it 'grants access if user is a support agent' do
      expect(subject).to permit(User.new(role: User::ROLE.agent), ticket(status: status.open))
    end

    context 'with closed ticket' do
      it 'denies access if user the owner of the ticket' do
        expect(subject).not_to permit(User.new(role: 'customer', id: 1), ticket(user_id: 1, status: status.closed))
      end

      it 'denies access if user is an admin' do
        expect(subject).not_to permit(User.new(role: User::ROLE.admin), ticket(status: status.closed))
      end

      it 'denies access if user is a support agent' do
        expect(subject).not_to permit(User.new(role: User::ROLE.agent), ticket(status: status.closed))
      end
    end
  end

  permissions :create? do
    it 'grants access if user is a customer' do
      expect(subject).to permit(User.new(role: 'customer'), ticket)
    end

    it 'denies access if user is an admin' do
      expect(subject).not_to permit(User.new(role: User::ROLE.admin), ticket)
    end

    it 'denies access if user is a support agent' do
      expect(subject).not_to permit(User.new(role: User::ROLE.agent), ticket)
    end
  end

  permissions :destroy? do
    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(role: User::ROLE.admin), ticket)
    end

    it 'denies access if user is an customer' do
      expect(subject).not_to permit(User.new(role: User::ROLE.customer), ticket)
    end

    it 'denies access if user is a support agent' do
      expect(subject).not_to permit(User.new(role: User::ROLE.agent), ticket)
    end
  end
end
