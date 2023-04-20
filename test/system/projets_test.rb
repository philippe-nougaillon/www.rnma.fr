require "application_system_test_case"

class ProjetsTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @projet = projets(:one)
  end

  test "visiting the index" do
    visit projets_url
    assert_selector "h1", text: "Projets"
  end

  test "creating a Projet" do
    visit projets_url
    click_on "+"

    fill_in "Chapeau", with: @projet.chapeau
    # fill_in "Slug", with: @projet.slug
    fill_in "Thème", with: @projet.thème
    fill_in "Titre", with: @projet.titre
    # fill_in "Workflow state", with: @projet.workflow_state
    click_on "Enregistrer"

    assert_text "Projet créé."
    click_on "Retour"
  end

  test "updating a Projet" do
    visit projets_url
    click_on "Modifier", match: :first

    fill_in "Chapeau", with: @projet.chapeau
    # fill_in "Slug", with: @projet.slug
    fill_in "Thème", with: @projet.thème
    fill_in "Titre", with: @projet.titre
    # fill_in "Workflow state", with: @projet.workflow_state
    click_on "Enregistrer"

    assert_text "Projet modifié."
    click_on "Retour"
  end

  test "destroying a Projet" do
    visit projets_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Projet détruit."
  end
end
