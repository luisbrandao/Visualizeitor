json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :grade, :frequency, :year, :semester, :status
  json.url enrollment_url(enrollment, format: :json)
end
