require "application_system_test_case"

class SibsTest < ApplicationSystemTestCase
  setup do
    @sib = sibs(:one)
  end

  test "visiting the index" do
    visit sibs_url
    assert_selector "h1", text: "Sibs"
  end

  test "creating a Sib" do
    visit sibs_url
    click_on "New Sib"

    fill_in "Envoyée le", with: @sib.envoyée_le
    fill_in "Intitulé", with: @sib.intitulé
    fill_in "Url", with: @sib.url
    click_on "Create Sib"

    assert_text "Sib was successfully created"
    click_on "Back"
  end

  test "updating a Sib" do
    visit sibs_url
    click_on "Edit", match: :first

    fill_in "Envoyée le", with: @sib.envoyée_le
    fill_in "Intitulé", with: @sib.intitulé
    fill_in "Url", with: @sib.url
    click_on "Update Sib"

    assert_text "Sib was successfully updated"
    click_on "Back"
  end

  test "destroying a Sib" do
    visit sibs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sib was successfully destroyed"
  end
end
