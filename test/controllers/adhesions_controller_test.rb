require "test_helper"

class AdhesionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user_admin_controller
    @adhesion = adhesions(:la_maison_des_tests)
  end

  test "should get index" do
    get adhesions_url
    assert_response :success
  end

  test "should get new" do
    get new_adhesion_url
    assert_response :success
  end

  test "should create adhesion" do
    assert_difference('Adhesion.count') do
      post adhesions_url, params: { adhesion: { adresse: @adhesion.adresse, cp: @adhesion.cp, email: @adhesion.email, maison_id: @adhesion.maison_id, nom: @adhesion.nom, organisme: @adhesion.organisme, prénom: @adhesion.prénom, téléphone: @adhesion.téléphone, ville: @adhesion.ville, workflow_state: @adhesion.workflow_state } }
    end

    assert_redirected_to adhesion_url(Adhesion.last)
  end

  test "should show adhesion" do
    get adhesion_url(@adhesion)
    assert_response :success
  end

  test "should get edit" do
    get edit_adhesion_url(@adhesion)
    assert_response :success
  end

  test "should update adhesion" do
    patch adhesion_url(@adhesion), params: { adhesion: { adresse: @adhesion.adresse, cp: @adhesion.cp, email: @adhesion.email, maison_id: @adhesion.maison_id, nom: @adhesion.nom, organisme: @adhesion.organisme, prénom: @adhesion.prénom, téléphone: @adhesion.téléphone, ville: @adhesion.ville, workflow_state: @adhesion.workflow_state } }
    assert_redirected_to adhesion_url(@adhesion)
  end

  test "should destroy adhesion" do
    assert_difference('Adhesion.count', -1) do
      delete adhesion_url(@adhesion)
    end

    assert_redirected_to adhesions_url
  end
end
