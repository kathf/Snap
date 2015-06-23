json.array!(@photos) do |photo|
  json.extract! photo, :id, :image, :description
  json.url photo_url(photo, format: :json)
end
