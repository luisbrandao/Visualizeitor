json.array!(@categories) do |category|
  json.extract! category, :id, :descr, :softlimit, :hardlimit, :activity
  json.url category_url(category, format: :json)
end
