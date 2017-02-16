require 'rails_helper'

describe User, type: :model do
  subject { create(:customer) }

  describe '.from_token_payload' do
    specify { expect(described_class.from_token_payload('sub' => subject.id)).to eql(subject) }
  end

  describe '.from_token_request' do
    context 'when user exists' do
      let(:request) { OpenStruct.new(params: { 'email' => subject.email }) }
      specify { expect(described_class.from_token_request(request)).to eql(subject) }
    end

    context 'when user does not exist' do
      let(:request) { OpenStruct.new(params: { 'email' => 'wrong@email.com' }) }

      it 'raises ApplicationError' do
        expect { described_class.from_token_request(request) }.to raise_error(ApplicationError)
      end
    end
  end

  describe '#to_token_payload' do
    let(:payload) do
      subject
        .attributes
        .slice('email', 'last_name', 'first_name', 'role')
        .update(sub: subject.id, full_name: subject.name)
    end

    specify { expect(subject.to_token_payload).to eql(payload) }
  end

  describe '#jwt_token' do
    subject { create(:customer) }
    specify { expect(subject.jwt_token).to eql(Knock::AuthToken.new(payload: subject.to_token_payload).token) }
  end
end
