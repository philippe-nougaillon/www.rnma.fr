require "test_helper"

class SibsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sib = sibs(:one)
  end

  test "should get index" do
    get sibs_url
    assert_response :success
  end

  test "should get new" do
    get new_sib_url
    assert_response :success
  end

  test "should create sib" do
    assert_difference('Sib.count') do
      post sibs_url, params: { sib: { envoyée_le: @sib.envoyée_le, intitulé: @sib.intitulé, url: @sib.url } }
    end

    assert_redirected_to sib_url(Sib.last)
  end

  test "should show sib" do
    get sib_url(@sib)
    assert_response :success
  end

  test "should get edit" do
    get edit_sib_url(@sib)
    assert_response :success
  end

  test "should update sib" do
    patch sib_url(@sib), params: { sib: { envoyée_le: @sib.envoyée_le, intitulé: @sib.intitulé, url: @sib.url } }
    assert_redirected_to sib_url(@sib)
  end

  test "should destroy sib" do
    assert_difference('Sib.count', -1) do
      delete sib_url(@sib)
    end

    assert_redirected_to sibs_url
  end
end
