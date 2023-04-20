require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  setup do
    login_user_admin
    @message = messages(:one)
  end

  test "visiting the index" do
    visit messages_url
    assert_selector "h1", text: "Messages"
  end

  test "creating a Message" do
    click_on "Déconnexion"
    click_on "Nous contacter"

    fill_in "message_nom", with: @message.nom
    fill_in "message_structure", with: @message.structure
    fill_in "message_email", with: @message.email
    fill_in "message_téléphone", with: @message.téléphone
    fill_in "message_message", with: @message.message
    click_on "Envoyer"

    assert_text "Votre message a bien été pris en compte, et sera traité dans les meilleurs délais."
    assert_selector "h1", text: "Bienvenue sur le site du RNMA"
  end

  test "updating a Message" do
    visit messages_url
    click_on "Modifier", match: :first

    fill_in "message_nom", with: @message.nom
    fill_in "message_structure", with: @message.structure
    fill_in "message_email", with: @message.email
    fill_in "message_téléphone", with: @message.téléphone
    fill_in "message_message", with: @message.message
    click_on "Envoyer"

    assert_text "Message modifié."
    click_on "Retour"
  end

  test "destroying a Message" do
    visit messages_url
    page.accept_confirm do
      click_on "[X]", match: :first
    end

    assert_text "Message détruit."
  end
end
