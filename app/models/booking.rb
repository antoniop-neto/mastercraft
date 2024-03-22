class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service
  has_many :reviews, dependent: :destroy
  has_one :chatroom, dependent: :destroy
  after_create :create_private_chatroom

  private

  def create_private_chatroom
    Chatroom.create(booking: self)
  end
end
