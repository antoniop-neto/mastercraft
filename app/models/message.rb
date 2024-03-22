class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  # Validations
  validates :content, presence: true
  validates :chatroom_id, presence: true
  validates :user_id, presence: true
end
