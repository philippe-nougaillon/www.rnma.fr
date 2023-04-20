require "application_system_test_case"

class EvenementsTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @evenement = evenements(:published_public_event_one)
  end

  test "visiting the index" do
    visit evenements_url
    assert_selector "h1", text: "Agenda des Évènements"
  end

  test "creating a Evenement" do
    visit evenements_url
    click_on "+"
    # fill_in "evenement_debut_3i", with: @evenement.debut.strftime('%H')
    fill_in "Titre", with: @evenement.titre
    fill_in "Chapeau", with: @evenement.chapeau
    fill_in "Lieu", with: @evenement.lieu
    click_on "Enregistrer"

    assert_text "Évènement créé."
    click_on "Retour"
    assert_selector "h1", text: "Agenda des Évènements"
  end

  test "updating a Evenement" do
    visit evenements_url
    click_on "Modifier", match: :first

    fill_in "Chapeau", with: @evenement.chapeau
    # fill_in "evenement_debut_3i", with: @evenement.debut
    fill_in "Lieu", with: @evenement.lieu
    fill_in "Titre", with: @evenement.titre
    click_on "Enregistrer"

    assert_text "Évènement modifié."
    click_on "Retour"
    assert_selector "h1", text: "Agenda des Évènements"
  end

  test "destroying a Evenement" do
    visit evenements_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end
    assert_text "Évènement détruit."
    assert_selector "h1", text: "Agenda des Évènements"
  end
end
