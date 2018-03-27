require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  test "should not save empty booking record" do
    booking = Booking.new
    assert_not booking.save, "Saved an empty booking record"
  end
end
