require 'rails_helper'

describe PasswordManager do
  subject { described_class.new }

  describe '#send_token' do
    let(:params) { attributes_for(:customer) }
    let!(:user) { create(:customer, params) }

    it 'sets reset_password_token' do
      expect { subject.send_token(params) }.to change { user.reload.reset_password_token }
    end

    it 'sends email with instructions' do
      expect { subject.send_token(params) }.to change(PasswordMailer.deliveries, :count).by(1)
      expect(PasswordMailer.deliveries.last.subject).to eql 'Reset password request'
    end
  end

  describe '#reset_password' do
    let!(:user) { create(:customer, reset_password_token: 'token') }
    let(:params) { { reset_password_token: 'token', password: 'qwerty123' } }

    it 'sets new password' do
      expect { subject.reset_password(params) }.to change { user.reload.password_digest }
    end

    it 'clear reset_password_token' do
      expect { subject.reset_password(params) }.to change { user.reload.reset_password_token }.to(nil)
    end
  end
end
