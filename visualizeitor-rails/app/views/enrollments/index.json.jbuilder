json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :decimal, :decimal, :year, :semester, :status
  json.url enrollment_url(enrollment, format: :json)
end
