class Event < ApplicationRecord

  mount_uploader :image, ImageUploader
  has_many :tickets, dependent: :destroy

end
