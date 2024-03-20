class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :destroy]
  before_action :set_service, only: [:new, :create]

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = @service.bookings.build
    @hours_range = (@service.user.start_hour..@service.user.end_hour).to_a
  end

  def create
    # @service = Service.find(params[:id])
    @booking = @service.bookings.build(booking_params)
    # @booking.service = @service
    @booking.user = current_user # getting the current user

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
      # this is when you fail to book, you will come back to new booking page
    end
  end

  def edit
  end

  def update
    @booking = Booking.update(booking_params)
  end

  def destroy
    @booking.destroy
    #redirect_to bookings_path, status: :see_other
  end
  private

  def set_booking
    @booking = Booking.find(params[:id]) # pass service_id as a param
  end

  def set_service
    @service = Service.find(params[:service_id])
  end

  def booking_params
    params.require(:booking).permit(:date, :start_hour)
  end
end
