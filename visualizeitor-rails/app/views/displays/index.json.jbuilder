json.array!(@displays) do |display|
  json.extract! display, :id
  json.url display_url(display, format: :json)
end
