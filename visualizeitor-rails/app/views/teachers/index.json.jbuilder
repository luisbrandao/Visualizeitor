json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :name, :login, :access, :email
  json.url teacher_url(teacher, format: :json)
end
