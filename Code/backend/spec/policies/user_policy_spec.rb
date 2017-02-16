require 'rails_helper'

describe UserPolicy do
  subject { described_class }

  permissions :index? do
    it 'denies access if user is a customer' do
      expect(subject).not_to permit(User.new(role: User::ROLE.customer))
    end

    it 'denies access if user is a support agent' do
      expect(subject).not_to permit(User.new(role: User::ROLE.agent))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(role: User::ROLE.admin))
    end
  end

  permissions :create? do
    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(role: User::ROLE.admin))
    end
    it 'grants access if user is nil' do
      expect(subject).to permit(nil)
    end
  end

  permissions :destroy? do
    it 'denies access if user is a customer' do
      expect(subject).not_to permit(User.new(role: User::ROLE.customer, id: 1), User.new(id: 1))
    end

    it 'denies access if user is a support agent' do
      expect(subject).not_to permit(User.new(role: User::ROLE.agent, id: 1), User.new(id: 1))
    end

    it 'denies access if user deletes itself' do
      expect(subject).not_to permit(User.new(role: User::ROLE.admin, id: 1), User.new(id: 1))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(role: User::ROLE.admin, id: 1), User.new(id: 2))
    end
  end
end
