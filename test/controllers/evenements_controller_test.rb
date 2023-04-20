require "test_helper"

class EvenementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user_admin_controller
    @evenement = evenements(:published_public_event_one)
  end

  test "should get index" do
    get evenements_url
    assert_response :success
  end

  test "should get new" do
    get new_evenement_url
    assert_response :success
  end

  test "should create evenement" do
    assert_difference('Evenement.count') do
      post evenements_url, params: { evenement: { chapeau: @evenement.chapeau, debut: @evenement.debut, fin: @evenement.fin, lieu: @evenement.lieu, titre: @evenement.titre } }
    end

    assert_redirected_to evenement_url(Evenement.last)
  end

  test "should show evenement" do
    get evenement_url(@evenement)
    assert_response :success
  end

  test "should get edit" do
    get edit_evenement_url(@evenement)
    assert_response :success
  end

  test "should update evenement" do
    patch evenement_url(@evenement), params: { evenement: { chapeau: @evenement.chapeau, debut: @evenement.debut, lieu: @evenement.lieu, titre: @evenement.titre } }
    assert_redirected_to evenement_url(@evenement)
  end

  test "should destroy evenement" do
    assert_difference('Evenement.count', -1) do
      delete evenement_url(@evenement)
    end

    assert_redirected_to evenements_url
  end
end
