require 'rails_helper'

describe UserManager, freeze: true do
  subject { described_class.new }

  describe '#create' do
    let(:params) { attributes_for(:customer) }

    it 'creates user' do
      expect { subject.create_customer(params) }.to change(User, :count).by(1)
    end

    context 'when email exists in db' do
      before { subject.create_customer(params) }

      it 'raises error ActiveRecord::RecordInvalid' do
        expect { subject.create_customer(params) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
