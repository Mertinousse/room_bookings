require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get error response" do
    post api_path, params: { "asd" => { "kek" => "000" } }, as: :json
    puts @response.body
    assert_equal JSON.parse(@response.body), { "error" => "JSON validation failed" }
  end

  test "should get booking response" do
    post api_path, params: { "booking" => { "room" => "001", "date" => "01-01-2018" } }, as: :json
    puts @response.body[:booked]
    assert_not_nil (JSON.parse(@response.body))[:booked]
  end
end
