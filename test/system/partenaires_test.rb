require "application_system_test_case"

class PartenairesTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @partenaire = partenaires(:one)
  end

  test "visiting the index" do
    visit partenaires_url
    assert_selector "h1", text: "Partenaires"
  end

  test "creating a Partenaire" do
    visit partenaires_url
    click_on "+"

    fill_in "Lien", with: @partenaire.lien
    fill_in "Nom", with: @partenaire.nom
    fill_in "Type partenaire", with: @partenaire.type_partenaire.keys
    click_on "Enregistrer"

    assert_text "Partenaire créé."
    click_on "Retour"
  end

  test "updating a Partenaire" do
    visit partenaires_url
    click_on "Modifier", match: :first

    fill_in "Lien", with: @partenaire.lien
    fill_in "Nom", with: @partenaire.nom
    fill_in "Type partenaire", with: @partenaire.type_partenaire.keys
    click_on "Enregistrer"

    assert_text "Partenaire modifié."
    click_on "Retour"
  end

  test "destroying a Partenaire" do
    visit partenaires_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Partenaire détruit."
  end
end
