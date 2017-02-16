class Reply < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  validates :body, :user, presence: true
  validates :user, associated: true
  validates :body, length: { maximum: 500 }
end
