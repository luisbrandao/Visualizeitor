json.array!(@evaluations) do |evaluation|
  json.extract! evaluation, :id, :state, :teacher_id, :acform_id, :comment
  json.url evaluation_url(evaluation, format: :json)
end
