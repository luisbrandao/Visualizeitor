json.array!(@companies) do |company|
  json.extract! company, :id, :name, :cnpj, :activity
  json.url company_url(company, format: :json)
end
