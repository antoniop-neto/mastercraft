class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

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
