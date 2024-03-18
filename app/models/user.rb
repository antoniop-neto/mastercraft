class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :services
  has_many :bookings, through: :services # , as: :received_bookings
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
