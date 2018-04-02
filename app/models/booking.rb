require 'pp'
# class BookingValidator < ActiveModel::Validator
#
#   def validate(record)
#     Booking.all.each do |b|
#       if record[:room] == b[:room] and record[:id] != b[:id]
#         if (record[:start] <=> b[:end]) < 0 and (record[:end] <=> b[:start]) > 0
#           record.errors[:base] << "The room is already booked during this time"
#           break
#         end
#       end
#     end
#   end
#
# end

class Booking < ActiveRecord::Base

  belongs_to :room

  validates_date :start, :on => :create, :on_or_after => :today
  validates_date :start, :on => :update, :before => :end
  validates_date :end, :after => :start
  # validates_with BookingValidator
  validate :check_date_conflict

  def check_date_conflict
    # Booking.where(room: self.room).find_each(batch_size: 100) do |b|
    #   next if b[:id] == self.id
    #   if (self.start <=> b[:end]) < 0 and (self.end <=> b[:start]) > 0
    #     errors[:base] << "The room is already booked during this time"
    #     break
    #   end
    # end
    # TODO: This one would be better, but raises an sql syntax error
    pp self
    existing_booking = Booking.where('"end" > :start AND start < :end AND room_id = :room', {
      start: self.start, end: self.end, room: self.room_id }).take
    pp existing_booking
    errors[:base] << "The room is already booked during this time" if existing_booking
  end

end
