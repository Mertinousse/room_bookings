require 'test_helper'

class BookingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bookings_path
    assert_response :success
  end
end
