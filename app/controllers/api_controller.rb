class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def info
    if request_valid? then
      @data[:date] = Date.parse(@data[:date])
      @res = { :booked => false }
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
    if (@data.has_key? :room and @data.has_key? :date)
      room = Room.new(number: @data[:room])
      d, m, y = @data[:date].split '-'
      return true if Date.valid_date? y.to_i, m.to_i, d.to_i and room.valid?
    end
    return false
  end

end
