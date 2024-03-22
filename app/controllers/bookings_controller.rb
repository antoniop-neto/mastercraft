class BookingsController < ApplicationController
  before_action :set_booking, only: [:destroy]
  before_action :set_service, only: [:new, :create]

  def index
    @user = current_user
    @sorted_bookings = current_user.bookings.order(:date, :start_hour)
    @grouped_bookings = @sorted_bookings.group_by { |booking| booking.date }
  end

  def appointments
    @booking = Booking.where(user_id: current_user.id)
    @sorted_bookings = @booking.order(:date, :start_hour)
    @grouped_bookings = @sorted_bookings.group_by { |booking| booking.date }
  end


  def show
    @booking = Booking.find(params[:id])
    @chatroom = Chatroom.find_by(booking_id: params[:id])
  end

  def new
    @booking = @service.bookings.build
    @selected_date = params[:date]
    @selected_timeslot = params[:timeslot]
    @hours_range = (@service.user.start_hour..@service.user.end_hour).to_a
  end

  def create
    # @service = Service.find(params[:id])
    @booking = @service.bookings.build(booking_params)
    # @booking.service = @service
    @booking.user = current_user # getting the current user
    dayslots = @service.user.dayslots

    if @booking.save
      # delete the timeslot
      dayslots.where(date: @booking.date).each do |dayslot|
        if dayslot.slots.include?(@booking.start_hour)
          dayslot.slots.delete(@booking.start_hour)
          dayslot.save
        end
      end
      @chatroom = Chatroom.create(booking: @booking)
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
      # this is when you fail to book, you will come back to new booking page
    end
  end


  def update
    @booking = Booking.update(booking_params)
  end

  def destroy
    start_hour = @booking.start_hour
    dayslot = @booking.service.user.dayslots.find_by(date: @booking.date)
    index = dayslot.slots.index { |slot| slot > start_hour } || -1
    dayslot.slots.insert(index, start_hour) unless dayslot.slots.include?(start_hour)
    dayslot.save
    @booking.destroy
    redirect_to root_path, status: :see_other
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
