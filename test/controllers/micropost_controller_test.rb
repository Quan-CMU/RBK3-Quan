require "test_helper"

class MicropostControllerTest < ActionDispatch::IntegrationTest
  test "should get micropost" do
    get micropost_micropost_url
    assert_response :success
  end
end
