class TicketsIndex < ApplicationIndex
  define_type Ticket.includes(:user) do
    field :user_id, type: :integer

    field :title
    field :body
    field :author, value: -> { user.name }
    field :status, index: :not_analyzed
    field :created_at, type: :date
    field :updated_at, type: :date
    field :closed_at, type: :date
  end
end
