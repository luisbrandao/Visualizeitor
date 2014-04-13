json.array!(@majors) do |major|
  json.extract! major, :id, :name, :code
  json.url major_url(major, format: :json)
end
