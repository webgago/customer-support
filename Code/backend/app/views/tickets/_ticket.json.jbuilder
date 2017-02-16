return unless ticket

json.extract! ticket,
              :id,
              :title,
              :body,
              :closed,
              :new,
              :status,
              :created_at,
              :closed_at,
              :updated_at

json.user do
  json.partial! 'users/user', user: ticket.user
end

json.replies do
  json.array! ticket.replies, partial: 'replies/reply', as: :reply
end
