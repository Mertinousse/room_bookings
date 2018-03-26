class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  @@schema = {
    "type" => "object",
    "required" => ["booking"],
    "properties" => {
      "booking" => {
        "type" => "object",
        "properties" => {
          "room" => {
            "type" => "string"
          },
          "date" => {
            "type" => "string"
          }
        }
      }
    }
  }

  def info
    data = params.require(:booking).permit(:room, :date)
    if JSON::Validator.validate(@@schema, data)
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
