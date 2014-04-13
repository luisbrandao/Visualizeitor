json.array!(@program_items) do |program_item|
  json.extract! program_item, :id, :row, :column
  json.url program_item_url(program_item, format: :json)
end
