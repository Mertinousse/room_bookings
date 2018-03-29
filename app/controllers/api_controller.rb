class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def info
    booking = Booking.new(params.require(:booking).permit(:room, :date))
    # if booking_present? and @data.has_key? :room and @data.has_key? :date
    if booking.valid?
      # @data[:date] = Date.parse(@data[:date])
      @res = { :booked => false }
      Booking.all.each do |b|
        # if (b[:start] <=> @data[:date]) < 1 and (@data[:date] <=> b[:end]) < 0 then
        if (b[:start] <=> booking[:date]) < 1 and (booking[:date] <=> b[:end]) < 0 then
          @res[:booked] = true
          break
        end
      end
    else
      @res = { "error" => "JSON validation failed" }
    end
    render :json => @res
  end

  # private
  # def booking_present?
  #   begin
  #     @data = params.require(:booking).permit(:room, :date)
  #   rescue ActionController::ParameterMissing => e
  #     return false
  #   end
  #   return true
  # end

end
