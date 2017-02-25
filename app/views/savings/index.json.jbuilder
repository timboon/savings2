json.array!(@savings) do |saving|
  json.extract! saving, :id
  json.url saving_url(saving, format: :json)
end
