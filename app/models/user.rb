class User < ApplicationRecord

  validates :password, length: { minimum: 3 }, presence: true, allow_nil: true

  validates :name, presence: true
  validates :email, presence: true

  has_many :tickets, dependent: :destroy

  has_secure_password

end
