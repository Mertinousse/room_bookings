class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def info
    if request_valid? then
      @data[:date] = Date.parse(@data[:date])
      @res = { :booked => false }
      # Booking.all.each do |b|
      #   if (b[:start] <=> @data[:date]) < 1 and (@data[:date] <=> b[:end]) < 0 then
      #     @res[:booked] = true
      #     break
      #   end
      # end
      existing_booking = Booking.where('"end" > :date AND start <= :date AND room_id = :room', {
        date: @data[:date], room: Room.find_by(number: @data[:room]) }).take
      @res[:booked] = true if existing_booking
    else
      @res = { "error" => "JSON validation failed" }
    end
    render :json => @res
  end

  private
  def request_valid?
    begin
      @data = params.require(:booking).permit(:room, :date)
    rescue ActionController::ParameterMissing => e
      return false
    end
    return (@data.has_key? :room and @data.has_key? :date)
  end

end
