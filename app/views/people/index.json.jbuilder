json.array!(@people) do |person|
  json.extract! person, :id, :user_id, :name, :github_account, :twitter_account
  json.url person_url(person, format: :json)
end
