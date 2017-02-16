json.cache! resource.data do
  json.extract! resource,
                :total,
                :threshold

  json.data do
    json.array! resource.data, partial: 'ticket', as: :ticket
  end

  json.query do
    json.extract! resource,
                  :period,
                  :status
  end
end
