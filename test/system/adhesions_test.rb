require "application_system_test_case"

class AdhesionsTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @adhesion = adhesions(:la_maison_des_tests)
  end

  test "visiting the index" do
    visit adhesions_url
    assert_selector "h1", text: "Adhésions"
  end

  test "creating a Adhesion" do
    visit adhesions_url
    click_on "+"

    fill_in "Nom de votre structure", with: @adhesion.maison
    fill_in "Adresse", with: @adhesion.adresse
    fill_in "Code postal", with: @adhesion.cp
    fill_in "Ville", with: @adhesion.ville
    fill_in "Votre nom", with: @adhesion.nom
    fill_in "Votre prénom", with: @adhesion.prénom
    fill_in "Téléphone", with: @adhesion.téléphone
    fill_in "Email", with: @adhesion.email
    fill_in "Fonction", with: @adhesion.fonction
    click_on "Ajouter document"
    assert_selector '[aria-label="Choisir un fichier"]'
    assert_text "Demande d'Adhésion créée avec succès."
  end

  test "updating a Adhesion" do
    visit adhesions_url
    click_on "Modifier", match: :first
    fill_in "Nom de votre structure", with: @adhesion.maison
    fill_in "Code postal", with: @adhesion.cp
    fill_in "Adresse", with: @adhesion.adresse
    fill_in "Email", with: @adhesion.email
    fill_in "Votre nom", with: @adhesion.nom
    fill_in "Fonction", with: @adhesion.fonction
    fill_in "Votre prénom", with: @adhesion.prénom
    fill_in "Téléphone", with: @adhesion.téléphone
    fill_in "Ville", with: @adhesion.ville
    click_on "Envoyer ma demande d'adhésion"

    assert_text "Adhésion modifiée."
  end

  # # test "destroying a Adhesion" do
  # #   visit adhesions_url
  # #   page.accept_confirm do
  # #     click_on "[X]", match: :first
  # #   end

  # #   assert_text "Adhésion détruite."
  # # end
end
