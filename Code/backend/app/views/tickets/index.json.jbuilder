json.cache! resource do
  json.array! resource, partial: 'tickets/ticket', as: :ticket
end
