require "test_helper"

class SlideshowImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user_admin_controller
    @slideshow_image = slideshow_images(:picture_1)
  end

  test "should get index" do
    get slideshow_images_url
    assert_response :success
  end

  test "should get new" do
    get new_slideshow_image_url
    assert_response :success
  end

  test "should create slideshow_image" do
    assert_difference('SlideshowImage.count') do
      post slideshow_images_url, params: { slideshow_image: { poids: @slideshow_image.poids, titre: @slideshow_image.titre } }
    end

    assert_redirected_to slideshow_image_url(SlideshowImage.last)
  end

  test "should show slideshow_image" do
    get slideshow_image_url(@slideshow_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_slideshow_image_url(@slideshow_image)
    assert_response :success
  end

  test "should update slideshow_image" do
    patch slideshow_image_url(@slideshow_image), params: { slideshow_image: { poids: @slideshow_image.poids, titre: @slideshow_image.titre } }
    assert_redirected_to slideshow_image_url(@slideshow_image)
  end

  test "should destroy slideshow_image" do
    assert_difference('SlideshowImage.count', -1) do
      delete slideshow_image_url(@slideshow_image)
    end

    assert_redirected_to slideshow_images_url
  end
end
