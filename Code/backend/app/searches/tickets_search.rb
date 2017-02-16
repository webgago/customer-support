# TicketsSearch allows to search and sort tickets in Elasticsearch
class TicketsSearch < ApplicationSearch
  use TicketsIndex::Ticket

  scope do
    includes(:user, :replies)
  end

  searchable :title, :body, :author

  term %i(user_id status)

  range created_at: :created_at
  range closed_at: :closed_at

  order_by updated_at: :updated_at, default: :asc
  order_by closed_at: :closed_at, default: :asc

  query :q
end
