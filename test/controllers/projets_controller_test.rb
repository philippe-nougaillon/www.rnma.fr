require "test_helper"

class ProjetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user_admin_controller
    @projet = projets(:one)
  end

  test "should get index" do
    get projets_url
    assert_response :success
  end

  test "should get new" do
    get new_projet_url
    assert_response :success
  end

  test "should create projet" do
    assert_difference('Projet.count') do
      post projets_url, params: { projet: { chapeau: @projet.chapeau, slug: @projet.slug, thème: @projet.thème, titre: @projet.titre, workflow_state: @projet.workflow_state } }
    end

    assert_redirected_to projet_url(Projet.last)
  end

  test "should show projet" do
    get projet_url(@projet)
    assert_response :success
  end

  test "should get edit" do
    get edit_projet_url(@projet)
    assert_response :success
  end

  test "should update projet" do
    patch projet_url(@projet), params: { projet: { chapeau: @projet.chapeau, slug: @projet.slug, thème: @projet.thème, titre: @projet.titre, workflow_state: @projet.workflow_state } }
    assert_redirected_to projet_url(@projet)
  end

  test "should destroy projet" do
    assert_difference('Projet.count', -1) do
      delete projet_url(@projet)
    end

    assert_redirected_to projets_url
  end
end
