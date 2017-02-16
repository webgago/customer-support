# UsersSearch allows to search users in Elasticsearch
class UsersSearch < ApplicationSearch
  use UsersIndex::User

  searchable :first_name, :last_name, :email

  term %i(role)

  query :q
end
