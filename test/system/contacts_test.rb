require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @contact = contacts(:sophie)
  end

  test "visiting the index" do
    visit contacts_url
    assert_selector "h1", text: "Contacts"
  end

  test "creating a Contact" do
    visit contacts_url
    click_on "+"

    fill_in "Email", with: @contact.email
    fill_in "Fonction", with: @contact.fonction
    fill_in "Maison", with: @contact.maison_id
    fill_in "Nom", with: @contact.nom
    fill_in "Prénom", with: @contact.prénom
    fill_in "Téléphone", with: @contact.téléphone
    click_on "Enregistrer"

    assert_text "Contact créé."
    click_on "Retour"
  end

  test "updating a Contact" do
    visit contacts_url
    click_on "Modifier", match: :first

    fill_in "Email", with: @contact.email
    fill_in "Fonction", with: @contact.fonction
    fill_in "Maison", with: @contact.maison_id
    fill_in "Nom", with: @contact.nom
    fill_in "Prénom", with: @contact.prénom
    fill_in "Téléphone", with: @contact.téléphone
    click_on "Enregistrer"

    assert_text "Contact modifié."
    click_on "Retour"
  end

  test "destroying a Contact" do
    visit contacts_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Contact détruit"
  end

  test "export XLS" do
    visit contacts_url

    click_on "Export XLS"
    sleep(4)
    assert File.exists?( File.expand_path "~/Downloads/RNMA_Export-Contacts.xls" )
  end

  #test filter les contacts par région do
  #end
end
