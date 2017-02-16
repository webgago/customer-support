return unless reply

json.extract! reply,
              :id,
              :body,
              :created_at,
              :updated_at

json.author do
  json.partial! 'users/user', user: reply.user
end
