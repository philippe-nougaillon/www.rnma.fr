require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user_admin_controller
    @contact = contacts(:sophie)
  end

  test "should get index" do
    get contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_url
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post contacts_url, params: { contact: { email: @contact.email, fonction: @contact.fonction, maison_id: @contact.maison_id, nom: @contact.nom, prénom: @contact.prénom, téléphone: @contact.téléphone } }
    end

    assert_redirected_to contact_url(Contact.last)
  end

  test "should show contact" do
    get contact_url(@contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_contact_url(@contact)
    assert_response :success
  end

  test "should update contact" do
    patch contact_url(@contact), params: { contact: { email: @contact.email, fonction: @contact.fonction, maison_id: @contact.maison_id, nom: @contact.nom, prénom: @contact.prénom, téléphone: @contact.téléphone } }
    assert_redirected_to contact_url(@contact)
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete contact_url(@contact)
    end

    assert_redirected_to contacts_url
  end
end
