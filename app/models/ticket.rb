class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event


  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :count, presence: true
end
