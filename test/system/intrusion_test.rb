require "application_system_test_case"

class IntrusionTest < ApplicationSystemTestCase

  setup do
    visit root_path
  end

  test "visitors don't have access to admin/index" do
    visit admin_index_path
    assert_selector "h1", text: "Connexion"
  end

  test "visitors don't have access to admin/memo" do
    visit admin_memo_path
    assert_selector "h1", text: "Connexion"
  end

  test "visitors don't have access to adhesions" do
    visit adhesions_path
    assert_no_selector "h1", text: "Adhésions"
    assert_selector "p", text: "Vous devez vous connecter ou vous inscrire pour continuer."
    assert_selector "h1", text: "Connexion"
  end

  test "visitors don't have access to adhesion show" do
    visit adhesions_path(1)
    # assert_no_selector "h1", text: Adhesion.find(1).titre
    assert_selector "p", text: "Vous devez vous connecter ou vous inscrire pour continuer."
  end
end
