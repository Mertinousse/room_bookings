
class Booking < ActiveRecord::Base

  belongs_to :room

  validates_date :start, :on => :create, :on_or_after => :today
  validates_date :start, :on => :update, :before => :end
  validates_date :end, :after => :start
  validate :check_date_conflict

  def check_date_conflict
    existing_booking = Booking.where('"end" > :start AND start < :end AND room_id = :room', {
      start: self.start, end: self.end, room: self.room_id }).take
    errors[:base] << "The room is already booked during this time" if existing_booking
  end

end
