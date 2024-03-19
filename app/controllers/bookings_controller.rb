class BookingsController < ApplicationController



















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

  def booking_params
    params.require(:booking).permit(:start_date_time)
  end
end
