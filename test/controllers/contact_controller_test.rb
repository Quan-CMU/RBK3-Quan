require "test_helper"

class ContactControllerTest < ActionDispatch::IntegrationTest
  test "should get action" do
    get contact_action_url
    assert_response :success
  end
end
