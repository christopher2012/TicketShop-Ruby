class CustomEventValidation < ActiveModel::Validator
  def validate(record)
    if !record.date_event
      record.errors[:date_event] << "nie może być pusta."
    elsif record.date_event < Time.now.to_date
      record.errors[:date_event] << "nie może być z przeszłości"
    end
  end
end

class Event < ApplicationRecord
  include ActiveModel::Validations

  validates :name, presence: true
  validates :description, presence: true
  validates :min_age, presence: true
  validates :seats, presence: true
  validates :price, presence: true
  validates :image, presence: true


  validates_with CustomEventValidation

  mount_uploader :image, ImageUploader
  has_many :tickets, dependent: :destroy

  scope :search, -> (search) { where("name like ?", "%#{search}%")}
  scope :ordered_by_price_asc, -> { reorder(price: :asc) }
  scope :ordered_by_date_asc, -> { reorder(date_event: :asc) }
  scope :ordered_by_price_desc, -> { reorder(price: :desc) }
  scope :ordered_by_date_desc, -> { reorder(date_event: :desc) }

end


