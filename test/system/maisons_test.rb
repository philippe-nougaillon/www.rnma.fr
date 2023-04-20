require "application_system_test_case"

class MaisonsTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @maison = maisons(:one)
  end

  test "visiting the index" do
    visit maisons_url
    assert_selector "h1", text: "Maisons"
  end

  # On créé une maison à partir d'une adhésion

  # test "creating a Maison" do
  #   visit maisons_url
  #   click_on "New Maison"

  #   fill_in "Cp", with: @maison.cp
  #   fill_in "Email", with: @maison.email
  #   fill_in "Nom", with: @maison.nom
  #   fill_in "Téléphone", with: @maison.téléphone
  #   fill_in "Ville", with: @maison.ville
  #   click_on "Enregistrer"

  #   assert_text "Maison créée."
  #   click_on "Retour"
  # end

  test "updating a Maison" do
    visit maisons_url
    click_on "Modifier", match: :first

    fill_in "Cp", with: @maison.cp
    fill_in "Email", with: @maison.email
    fill_in "Nom", with: @maison.nom
    fill_in "Téléphone", with: @maison.téléphone
    fill_in "Ville", with: @maison.ville
    click_on "Enregistrer"

    assert_text "Maison modifiée."
    click_on "Retour"
  end

  test "destroying a Maison" do
    visit maisons_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Maison was successfully destroyed"
  end
end
