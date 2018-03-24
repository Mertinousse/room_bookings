class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
  end

  def create
    @booking = Booking.new(params.require(:booking).permit(:room, :start, :end))
    if @booking.save
      flash[:success] = "Booking created for room #{@booking.room}"
      redirect_to bookings_path
    else
      render "new"
    end
  end

  def new
    @booking = Booking.new
  end

  def destroy

  end

end
