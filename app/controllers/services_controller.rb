class ServicesController < ApplicationController
  def index
    @services = Service.all

  # The `geocoded` scope filters only service with coordinates
    @markers = @services.geocoded.map do |service|
      {
        lat: service.latitude,
        lng: service.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {service: service}),
        marker_html: render_to_string(partial: "marker", locals: {service: service})
      }
    end

    # searchbar function
    if params[:query].present?
      sql_subquery = <<~SQL
        services.name @@ :query
        OR services.address @@ :query
        OR users.last_name @@ :query
        OR users.first_name @@ :query
      SQL
      @services = @services.joins(:user).where(sql_subquery, query: params[:query])
    end
  end

  def manage
    @user = current_user
    @services = current_user.services
  end

  def show
    @service = Service.find(params[:id])
    @dayslots = @service.user.dayslots.order(:date)
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    if @service.save
      redirect_to root_path, notice: 'Service was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
  end

  private

  def service_params
    params.require(:service).permit(:name, :price, :address, :photo)
  end

end
