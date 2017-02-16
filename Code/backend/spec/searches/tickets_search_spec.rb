require 'rails_helper'

RSpec.describe TicketsSearch do
  subject { described_class.new(params).search.to_a }
  let(:target_ticket) { create(:ticket, :hipster) }
  let(:sample_tickets) { [target_ticket, *create_list(:ticket, 3)] }

  before do
    described_class.type.import! sample_tickets
  end

  def sample_word(string)
    string.split(' ').sample
  end

  context 'search in title' do
    let(:word) { sample_word(target_ticket.title) }
    let(:params) { { q: word } }

    specify { expect(subject).to match_array([target_ticket]) }
  end

  context 'search in body' do
    let(:word) { sample_word(target_ticket.body) }
    let(:params) { { q: word } }

    specify { expect(subject).to match_array([target_ticket]) }
  end

  context 'search in author\'s name' do
    let(:word) { sample_word(target_ticket.user.name) }
    let(:params) { { q: word } }

    specify { expect(subject).to match_array([target_ticket]) }
  end

  context 'filter by user_id' do
    let(:params) { { user_id: target_ticket.user_id } }

    specify { expect(subject).to match_array([target_ticket]) }
  end

  context 'filter by status' do
    let(:target_ticket) { create(:ticket, :closed) }
    let(:params) { { status: target_ticket.status } }

    specify { expect(subject).to match_array([target_ticket]) }
  end

  context 'filter by created_at' do
    let(:target_ticket) { create(:ticket, created_at: 2.days.ago) }
    let(:params) do
      { created_at_from: target_ticket.created_at - 3.days,
        created_at_to: target_ticket.created_at + 1.day }
    end

    specify { expect(subject).to match_array([target_ticket]) }
  end

  context 'filter by closed_at' do
    let(:target_ticket) { create(:ticket, closed_at: 2.days.ago) }
    let(:params) do
      { closed_at_from: target_ticket.closed_at - 3.days,
        closed_at_to: target_ticket.closed_at + 1.day }
    end

    specify { expect(subject).to match_array([target_ticket]) }
  end

  context 'order by closed_at' do
    let(:sample_tickets) { [target_ticket, *create_list(:ticket, 3, closed_at: 1.day.ago)] }

    context 'asc' do
      let(:target_ticket) { create(:ticket, closed_at: 2.days.ago) }
      let(:params) { { closed_at: :asc } }

      specify { expect(subject.first).to eql(target_ticket) }
    end
    context 'desc' do
      let(:target_ticket) { create(:ticket, closed_at: 2.days.ago) }
      let(:params) { { closed_at: :desc } }

      specify { expect(subject.last).to eql(target_ticket) }
    end
  end

  context 'order by closed_at' do
    let(:sample_tickets) { [target_ticket, *create_list(:ticket, 3, updated_at: 1.day.ago)] }

    context 'asc' do
      let(:target_ticket) { create(:ticket, updated_at: 2.days.ago) }
      let(:params) { { updated_at: :asc } }

      specify { expect(subject.first).to eql(target_ticket) }
    end
    context 'desc' do
      let(:target_ticket) { create(:ticket, updated_at: 2.days.ago) }
      let(:params) { { updated_at: :desc } }

      specify { expect(subject.last).to eql(target_ticket) }
    end
  end
end
