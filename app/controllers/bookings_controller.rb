class BookingsController < ApplicationController
  before_action :set_service, only: [:new, :create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user # getting the current user

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.update(booking_params)
  end

  def destroy
    @booking.Booking.find(params[:id])
    @booking.destroy
    #redirect_to bookings_path, status: :see_other
  end
  private

  def set_service
    @service = Service.find(params[:service_id]) # pass service_id as a param
  end

  def booking_params
    params.require(:booking).permit(:service_id, :start_date_time)
  end
end
