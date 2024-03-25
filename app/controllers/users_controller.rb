class UsersController < ApplicationController
  before_action :set_provider_boolean, :set_address, :set_dayslots, :set_average_rating

  def index
    if params[:query].present?
      @users = User.global_search(params[:query])
    else
      @users = User.all
    end

    # The `geocoded` scope filters only user with coordinates
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {user: user}),
        marker_html: render_to_string(partial: "marker", locals: {user: user})
      }
    end
  end

  def show
    @user = User.find(params[:id])
    @services = @user.services
  end

  private

  def set_provider_boolean
    User.find_each do |user|
      user.update(provider: user.services.exists?)
    end
  end

  def set_address
    User.includes(:services).find_each do |user|
      # Using 'includes(:services)' to prevent N+1 query problem.
      if user.services.any?
        user.update(address: user.services.first.address)
        # Directly using 'update' to change and save the user's address.
        # This is more efficient and concise.
      end
    end
  end

  def set_dayslots
    User.find_each do |user|
      next if user.dayslot_set || !user.start_date || !user.end_date || !user.start_hour || !user.end_hour

      (user.start_date..user.end_date).each do |date|
        slots_array = (user.start_hour..user.end_hour-1).to_a
        Dayslot.create!(date: date, slots: slots_array, user: user)
      end
      # update the boolean, so that each user only sets dayslots once
      user.update(dayslot_set: true)
    end
  end

  def set_average_rating
    User.find_each do |user|
      total = 0
      count = 0
      user.services.each do |service|
        service.bookings.each do |booking|
          if booking.reviews.present?
            booking.reviews.each do |review|
              total += review.rating
              count += 1
            end
          end
        end
      end
      if count > 0
        user.rating = total.to_f / count
      else
        user.rating = 0
      end
      user.save
    end
  end
end
