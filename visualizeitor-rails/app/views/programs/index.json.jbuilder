json.array!(@programs) do |program|
  json.extract! program, :id, :name, :code, :year
  json.url program_url(program, format: :json)
end
