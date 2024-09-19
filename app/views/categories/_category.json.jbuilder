json.extract! category, :id, :name, :description, :images, :created_at, :updated_at
json.url category_url(category, format: :json)
json.description category.description.to_s
json.images do
  json.array!(category.images) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
