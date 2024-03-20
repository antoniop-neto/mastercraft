class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings

  def users_have_booked
    self.bookings.map {|booking| booking.user }
  end
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
