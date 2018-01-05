class CustomUserValidation < ActiveModel::Validator
  def validate(record)
    if !record.age
      record.errors[:age] << "nie może być pusta."
    elsif record.age > Time.now.to_date
      record.errors[:age] << "nie może być z przyszłości."
    end
  end
end



class User < ApplicationRecord
  include ActiveModel::Validations
  validates :password, length: { minimum: 3 }, presence: true, allow_nil: true

  validates :name, presence: true
  validates :email, presence: true
  validates_with CustomUserValidation

  has_many :tickets, dependent: :destroy

  has_secure_password

end
