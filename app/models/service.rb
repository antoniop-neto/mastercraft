class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings
  has_one_attached :photo

  def users_have_booked
    self.bookings.map {|booking| booking.user }
  end

  def opening_slots
    slots = []
    loop do
      new_slot = self.start_time
      slots << new_slot
      new_slot = new_slot + 1.hour
      break if new_slot > self.end_time
    end
    slots
  end

end
