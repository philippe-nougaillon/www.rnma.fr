require "application_system_test_case"

class RessourcesTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @ressource = ressources(:one)
  end

  test "visiting the index" do
    visit ressources_url
    assert_selector "h1", text: "Ressources"
  end

  test "creating a Ressource" do
    visit ressources_url
    click_on "+"

    fill_in "Chapeau", with: @ressource.chapeau
    # fill_in "Slug", with: @ressource.slug
    fill_in "Titre", with: @ressource.titre
    # fill_in "Workflow state", with: @ressource.workflow_state
    click_on "Enregistrer"

    assert_text "Ressource créée."
    click_on "Retour"
  end

  test "updating a Ressource" do
    visit ressources_url
    click_on "Modifier", match: :first

    fill_in "Chapeau", with: @ressource.chapeau
    # fill_in "Slug", with: @ressource.slug
    fill_in "Titre", with: @ressource.titre
    # fill_in "Workflow state", with: @ressource.workflow_state
    click_on "Enregistrer"

    assert_text "Ressource modifiée."
    click_on "Retour"
  end

  test "destroying a Ressource" do
    visit ressources_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Ressource détruite."
  end
end
