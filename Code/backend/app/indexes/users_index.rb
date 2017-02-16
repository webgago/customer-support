class UsersIndex < ApplicationIndex
  define_type User do
    field :first_name
    field :last_name
    field :email, analyzer: :email
    field :role, index: :not_analyzed
    field :created_at, type: :date
    field :updated_at, type: :date
  end
end
