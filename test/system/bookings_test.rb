require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase
  test "creating a booking" do
    visit bookings_path
    puts "1"
    click_on "new-booking"
    puts "2"
    fill_in "booking[room]", with: "001"
    puts "3"
    click_on "commit"
    puts "4"
    assert_selector ".border-danger .card-text", text: "Start is not a valid date"
  end
end
