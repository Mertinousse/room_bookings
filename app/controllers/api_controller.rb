class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def info
    data = params.require(:booking).permit(:room, :date)
    if data.has_key? :room and data.has_key? :date
      data[:date] = Date.parse(data[:date])
      @resp = { :booked => false }
      Booking.all.each do |b|
        if (b[:start] <=> data[:date]) < 1 and (data[:date] <=> b[:end]) < 0 then
          @resp[:booked] = true
          break
        end
      end
    else
      @resp = { "error" => "JSON validation failed" }
    end
    render :json => @resp
  end

end
