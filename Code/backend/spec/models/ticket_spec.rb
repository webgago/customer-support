require 'rails_helper'

describe Ticket, type: :model do
  describe '#closed?' do
    subject { build(:ticket, :closed) }

    specify { expect(subject).to be_closed }
  end
end
