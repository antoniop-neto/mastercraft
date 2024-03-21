class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :services, dependent: :destroy
  has_many :bookings, through: :services # , as: :received_bookings
  has_many :dayslots, dependent: :destroy
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :first_name, :last_name ],
    associated_against: {
      services: [ :name, :address ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
