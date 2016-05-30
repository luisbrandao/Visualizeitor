json.array!(@internships) do |internship|
  json.extract! internship, :id, :start, :end, :hours, :assistType, :internType, :student_id, :teacher_id, :contact_id
  json.url internship_url(internship, format: :json)
end
