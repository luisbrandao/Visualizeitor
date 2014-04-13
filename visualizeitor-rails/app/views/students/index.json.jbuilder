json.array!(@students) do |student|
  json.extract! student, :id, :name, :grr
  json.url student_url(student, format: :json)
end
