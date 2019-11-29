class Exhibition < ApplicationRecord
    has_many :tickets
    mount_uploader :image, ImageUploader
end
