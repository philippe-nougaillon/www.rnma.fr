require "application_system_test_case"

class SlideshowImagesTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @slideshow_image = slideshow_images(:picture_1)
  end

  test "visiting the index" do
    visit slideshow_images_url
    assert_selector "h1", text: "Slideshow Images"
  end

  test "creating a Slideshow image" do
    visit slideshow_images_url
    click_on "Nouvelle Image"

    fill_in "Poids", with: @slideshow_image.poids
    fill_in "Titre", with: @slideshow_image.titre
    fill_in "Image", with: @slideshow_image.image
    click_on "Enregistrer"

    assert_text "Image créée."
    click_on "Retour"
  end

  test "updating a Slideshow image" do
    visit slideshow_images_url
    click_on "Modifier", match: :first

    fill_in "Poids", with: @slideshow_image.poids
    fill_in "Titre", with: @slideshow_image.titre
    fill_in "Image", with: @slideshow_image.image
    click_on "Enregistrer"

    assert_text "Image modifiée."
    click_on "Retour"
  end

  test "destroying a Slideshow image" do
    visit slideshow_images_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Image détruite."
  end
end
