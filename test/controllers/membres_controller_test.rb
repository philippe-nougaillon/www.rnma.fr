require "test_helper"

class MembresControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user_member_controller
  end
  test "should get index" do
    get membres_index_url
    assert_response :success
  end

  test "should get maison" do
    get membres_maison_url
    assert_response :success
  end
end
