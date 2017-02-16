class Ticket < ApplicationRecord
  STATUS = OpenStruct.new(new: 'new'.freeze, open: 'open'.freeze, closed: 'closed'.freeze).freeze
  PRIORITY = OpenStruct.new(high: 'high'.freeze, medium: 'medium'.freeze, low: 'low'.freeze).freeze

  update_index 'tickets#ticket', :self

  belongs_to :user
  has_many :replies, foreign_key: :ticket_id

  validates :title, :body, presence: true
  validates :title, length: { maximum: 255 }
  validates :body, length: { maximum: 2000 }
  validates :priority, inclusion: { in: PRIORITY.to_h.values }

  def closed?
    status == STATUS.closed
  end
end
