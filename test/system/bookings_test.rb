require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase
  test "creating a booking" do
    visit bookings_path
    click_on "new-booking"
    fill_in "booking[room]", with: "001"
    click_on "commit"
    assert_selector ".border-danger .card-text", text: "Start is not a valid date"
  end
end
