require 'rails_helper'

describe ReportsPolicy do
  subject { described_class }

  permissions :show? do
    it 'denies access if user is a customer' do
      expect(subject).not_to permit(User.new(role: User::ROLE.customer))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(role: User::ROLE.admin))
    end

    it 'grants access if user is a support agent' do
      expect(subject).to permit(User.new(role: User::ROLE.agent))
    end
  end
end
