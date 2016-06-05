json.array!(@activities) do |activity|
  json.extract! activity, :id, :start, :end, :hours, :hoursvalid, :acform_id, :category_id
  json.url activity_url(activity, format: :json)
end
