json.extract! artifact, :id, :name, :image, :description, :category_id, :amount, :created_at, :updated_at
json.url artifact_url(artifact, format: :json)
