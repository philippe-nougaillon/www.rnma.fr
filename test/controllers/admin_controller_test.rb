require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user_admin_controller
  end

  test "should get index" do
    get admin_index_url
    assert_response :success
  end
end
