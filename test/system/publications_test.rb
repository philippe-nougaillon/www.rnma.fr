require "application_system_test_case"

class PublicationsTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @publication = publications(:one)
  end

  test "visiting the index" do
    visit publications_url
    assert_selector "h1", text: "Publications"
  end

  test "creating a Publication" do
    visit publications_url
    click_on "+"

    fill_in "Chapeau", with: @publication.chapeau
    # fill_in "Contenu", with: @publication.contenu
    # fill_in "Lien", with: @publication.lien
    fill_in "Titre", with: @publication.titre
    click_on "Enregistrer"

    assert_text "Publication créée."
    click_on "Retour"
  end

  test "updating a Publication" do
    visit publications_url
    click_on "Modifier", match: :first

    fill_in "Chapeau", with: @publication.chapeau
    # fill_in "Contenu", with: @publication.contenu
    # fill_in "Lien", with: @publication.lien
    fill_in "Titre", with: @publication.titre
    click_on "Enregistrer"

    assert_text "Publication modifiée."
    click_on "Retour"
  end

  test "destroying a Publication" do
    visit publications_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Publication détruite."
  end
end
