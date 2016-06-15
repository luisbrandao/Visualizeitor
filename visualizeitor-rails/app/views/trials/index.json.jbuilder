json.array!(@trials) do |trial|
  json.extract! trial, :id, :state, :teacher_id, :acform_id, :comment, :acctual
  json.url trial_url(trial, format: :json)
end
