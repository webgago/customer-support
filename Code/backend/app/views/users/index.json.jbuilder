json.cache! resource do
  json.array! resource, partial: 'users/user', as: :user
end
