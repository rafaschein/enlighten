json.array!(@clients) do |client|
  json.extract! client, :id, :name, :website
  json.url client_url(client, format: :json)
end
