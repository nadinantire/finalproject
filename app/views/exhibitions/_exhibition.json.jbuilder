json.extract! exhibition, :id, :name, :start_time, :end_time, :image, :date, :created_at, :updated_at
json.url exhibition_url(exhibition, format: :json)
