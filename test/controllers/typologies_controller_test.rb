require "test_helper"

class TypologiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user_admin_controller
    @typology = typologies(:one)
  end

  test "should get index" do
    get typologies_url
    assert_response :success
  end

  test "should get new" do
    get new_typology_url
    assert_response :success
  end

  test "should create typology" do
    assert_difference('Typology.count') do
      post typologies_url, params: { typology: { nom: @typology.nom } }
    end

    assert_redirected_to typology_url(Typology.last)
  end

  test "should show typology" do
    get typology_url(@typology)
    assert_response :success
  end

  test "should get edit" do
    get edit_typology_url(@typology)
    assert_response :success
  end

  test "should update typology" do
    patch typology_url(@typology), params: { typology: { nom: @typology.nom } }
    assert_redirected_to typology_url(@typology)
  end

  test "should destroy typology" do
    assert_difference('Typology.count', -1) do
      delete typology_url(@typology)
    end

    assert_redirected_to typologies_url
  end
end
