require "application_system_test_case"

class TypologiesTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @typology = typologies(:one)
  end

  test "visiting the index" do
    visit typologies_url
    assert_selector "h1", text: "Typologies"
  end

  test "creating a Typology" do
    visit typologies_url
    click_on "Nouvelle Typologie"

    fill_in "Nom", with: @typology.nom
    click_on "Enregistrer"

    assert_text "Typologie créée."
    click_on "Retour"
  end

  test "updating a Typology" do
    visit typologies_url
    click_on "Modifier", match: :first

    fill_in "Nom", with: @typology.nom
    click_on "Enregistrer"

    assert_text "Typologie modifiée."
    click_on "Retour"
  end

  test "destroying a Typology" do
    visit typologies_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Typologie détruite."
  end
end
