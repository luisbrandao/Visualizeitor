json.array!(@documents) do |document|
  json.extract! document, :id, :descr, :activity
  json.url document_url(document, format: :json)
end
