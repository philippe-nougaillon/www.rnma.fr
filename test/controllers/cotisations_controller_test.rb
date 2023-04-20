require "test_helper"

class CotisationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user_admin_controller
    @cotisation = cotisations(:one)
  end

  test "should get index" do
    get cotisations_url
    assert_response :success
  end

  test "should get new" do
    get new_cotisation_url
    assert_response :success
  end

  test "should create cotisation" do
    assert_difference('Cotisation.count') do
      post cotisations_url, params: { cotisation: { adhesion_id: @cotisation.adhesion_id, date_échéance: @cotisation.date_échéance, montant: @cotisation.montant, mémo: @cotisation.mémo, période: @cotisation.période, workflow_state: @cotisation.workflow_state } }
    end

    assert_redirected_to cotisation_url(Cotisation.last)
  end

  test "should show cotisation" do
    get cotisation_url(@cotisation)
    assert_response :success
  end

  test "should get edit" do
    get edit_cotisation_url(@cotisation)
    assert_response :success
  end

  test "should update cotisation" do
    patch cotisation_url(@cotisation), params: { cotisation: { adhesion_id: @cotisation.adhesion_id, date_échéance: @cotisation.date_échéance, montant: @cotisation.montant, mémo: @cotisation.mémo, période: @cotisation.période, workflow_state: @cotisation.workflow_state } }
    assert_redirected_to cotisation_url(@cotisation)
  end

  test "should destroy cotisation" do
    assert_difference('Cotisation.count', -1) do
      delete cotisation_url(@cotisation)
    end

    assert_redirected_to cotisations_url
  end
end
