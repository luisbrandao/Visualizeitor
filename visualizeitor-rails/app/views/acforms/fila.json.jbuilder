json.array!(@acforms) do |acform|
  json.extract! acform, :id, :state, :student_id
  json.url acform_url(acform, format: :json)
end
