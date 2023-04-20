require "application_system_test_case"

class ActionsTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @action = actions(:one)
  end

  test "visiting the index" do
    visit actions_url
    assert_selector "h1", text: "Actions"
  end

  test "creating a Action" do
    visit actions_url
    click_on "+"

    fill_in "Contact", with: @action.contact_id
    fill_in "Intitulé", with: @action.intitulé
    fill_in "Mémo", with: @action.mémo
    click_on "Enregistrer"

    assert_text "Action créé."
    click_on "Retour"
  end

  test "updating a Action" do
    visit actions_url
    click_on "Modifier", match: :first

    fill_in "Contact", with: @action.contact_id
    fill_in "Intitulé", with: @action.intitulé
    fill_in "Mémo", with: @action.mémo
    click_on "Enregistrer"

    assert_text "Action modifiée."
    click_on "Retour"
  end

  test "destroying a Action" do
    visit actions_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Action détruite."
  end
end
