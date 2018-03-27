require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  test "should not save empty booking record" do
    booking = Booking.new
    assert_not booking.save
  end

  test "should not save invalid booking record" do
    booking = Booking.new(room: "asd", start: Date.today, end: Date.today)
    assert_not booking.save
  end

  test "should save valid booking record" do
    booking = Booking.new(room: "001", start: Date.today, end: Date.today + 1)
    assert booking.save
  end
end
