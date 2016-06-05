json.array!(@categories) do |category|
  json.extract! category, :id, :descr, :softlimit, :hardlimit
  json.url category_url(category, format: :json)
end
