require 'rails_helper'

RSpec.describe UsersSearch do
  subject { described_class.new(params).search.to_a }
  let(:target_user) { create(:admin, first_name: 'Thomas', last_name: 'Anderson', email: 't.anderson@example.com') }
  let(:sample_users) { [target_user, *create_list(:customer, 3)] }

  before do
    described_class.type.import! sample_users
  end

  def sample_word(string)
    string.split(' ').sample
  end

  context 'search in first_name' do
    let(:word) { sample_word(target_user.first_name) }
    let(:params) { { q: word } }

    specify { expect(subject).to match_array([target_user]) }
  end

  context 'search in last_name' do
    let(:word) { sample_word(target_user.last_name) }
    let(:params) { { q: word } }

    specify { expect(subject).to match_array([target_user]) }
  end

  context 'search in email' do
    let(:word) { sample_word(target_user.email) }
    let(:params) { { q: word } }

    specify { expect(subject).to match_array([target_user]) }
  end

  context 'filter by role' do
    let(:params) { { role: target_user.role } }

    specify { expect(subject).to match_array([target_user]) }
  end
end
