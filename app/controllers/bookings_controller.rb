class BookingsController < ApplicationController

  before_action :set_booking, only: [ :destroy, :update, :edit ]

  def index
    @bookings = Booking.all.sort_by &:start
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      flash[:success] = "Booking has been created for room #{@booking.room}"
      redirect_to bookings_path
    else
      render "new"
    end
  end

  def new
    @booking = Booking.new
    @room_select = true
  end

  def edit
    @room_select = false
  end

  def update
    if @booking.update(booking_params)
      flash[:success] = "Booking has been updated for room #{@booking.room}"
      redirect_to bookings_path
    else
      render "edit"
    end
  end

  def destroy
    @booking.destroy
    flash[:danger] = "Booking has been successfully deleted"
    redirect_to bookings_path
  end

  private
  def booking_params
    params.require(:booking).permit(:room, :start, :end)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

end
