class CustomEventValidation < ActiveModel::Validator
  def validate(record)
    if !record.date_event
      record.errors[:date_event] << "nie może być pusta"
    elsif record.date_event < Time.now.to_date
      record.errors[:date_event] << "nie może być z przeszłości"
    end
  end
end

class Event < ApplicationRecord
  include ActiveModel::Validations

  validates :name, presence: true
  validates :description, presence: true
  validates :date_event, presence: true
  validates :min_age, presence: true
  validates :seats, presence: true
  validates :price, presence: true
  validates :image, presence: true


  validates_with CustomEventValidation

  mount_uploader :image, ImageUploader
  has_many :tickets, dependent: :destroy

end
