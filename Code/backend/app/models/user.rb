class User < ApplicationRecord
  ROLE = OpenStruct.new(admin: 'admin'.freeze, agent: 'support_agent'.freeze, customer: 'customer'.freeze).freeze

  update_index 'users#user', :self
  has_secure_password

  include UserAuth

  has_many :tickets, dependent: :restrict_with_error

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def name
    "#{first_name} #{last_name}"
  end

  def support_agent?
    role == ROLE.agent
  end

  def customer?
    role == ROLE.customer
  end

  def admin?
    role == ROLE.admin
  end
end
