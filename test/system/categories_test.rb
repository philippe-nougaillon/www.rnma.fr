require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @category = categories(:one)
  end

  test "visiting the index" do
    visit categories_url
    assert_selector "h1", text: "Catégories"
  end

  test "creating a Category" do
    visit categories_url
    click_on "Nouvelle Catégorie"

    fill_in "Nom", with: @category.nom
    click_on "Enregistrer"

    assert_text "Catégorie créée."
    click_on "Retour"
  end

  test "updating a Category" do
    visit categories_url
    click_on "Modifier", match: :first

    fill_in "Nom", with: @category.nom
    click_on "Enregistrer"

    assert_text "Catégorie modifiée."
    click_on "Retour"
  end

  test "destroying a Category" do
    visit categories_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Catégorie détruite."
  end
end
