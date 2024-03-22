class Chatroom < ApplicationRecord
  belongs_to :booking
  has_many :messages, dependent: :destroy
  # Validations
  # Add any validations here if required, for example:
  validates :booking_id, presence: true, uniqueness: true
  # Helper method to check if a user is a part of this chatroom
  def has_access?(user)
    booking.user_id == user.id || booking.service.user_id == user.id
  end
end
