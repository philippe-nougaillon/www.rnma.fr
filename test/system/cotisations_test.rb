require "application_system_test_case"

class CotisationsTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @cotisation = cotisations(:one)
  end

  test "visiting the index" do
    visit cotisations_url
    assert_selector "h1", text: "Cotisations"
  end

  test "creating a Cotisation" do
    visit cotisations_url
    click_on "New Cotisation"

    fill_in "Adhesion", with: @cotisation.adhesion_id
    fill_in "Date échéance", with: @cotisation.date_échéance
    fill_in "Montant", with: @cotisation.montant
    fill_in "Mémo", with: @cotisation.mémo
    fill_in "Période", with: @cotisation.période
    fill_in "Workflow state", with: @cotisation.workflow_state
    click_on "Create Cotisation"

    assert_text "Cotisation créée."
    click_on "Retour"
  end

  test "updating a Cotisation" do
    visit cotisations_url
    click_on "Modifier", match: :first

    fill_in "Adhesion", with: @cotisation.adhesion_id
    fill_in "Date échéance", with: @cotisation.date_échéance
    fill_in "Montant", with: @cotisation.montant
    fill_in "Mémo", with: @cotisation.mémo
    fill_in "Période", with: @cotisation.période
    fill_in "Workflow state", with: @cotisation.workflow_state
    click_on "Enregistrer"

    assert_text "Cotisation modifiée."
    click_on "Retour"
  end

  test "destroying a Cotisation" do
    visit cotisations_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Cotisation détruite."
  end
end
