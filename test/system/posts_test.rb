require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @post = posts(:published_public_post_one)
    visit posts_url
  end

  test "visiting the index" do
    assert_selector "h1", text: "Actualités"
  end

  test "creating a Post" do
    click_on "+"

    fill_in "Titre", with: @post.titre
    fill_in "Chapeau", with: @post.chapeau
    click_on "Enregistrer"

    assert_text "Actualité créée."
    click_on "Retour"
  end

  test "updating a Post" do
    click_on "Modifier", match: :first

    fill_in "Chapeau", with: @post.chapeau
    fill_in "Titre", with: @post.titre
    # fill_in "Workflow state", with: @post.workflow_state
    click_on "Enregistrer"

    assert_text "Actualité modifiée."
    click_on "Retour"
  end

  test "destroying a Post" do
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Actualité détruite."
  end
end
