json.array!(@documents) do |document|
  json.extract! document, :id, :descr, :activity_id
  json.url document_url(document, format: :json)
end
