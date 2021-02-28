require "test_helper"

class ReceiverControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    post receiver_create_url
    assert_response :success
  end
end
