class UsersController < ApplicationController
  before_action :set_provider_boolean, :set_address

  def index
    @users = User.all

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
end
