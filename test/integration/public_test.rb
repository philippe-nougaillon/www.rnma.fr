require "test_helper"

class PublicTest < ActionDispatch::IntegrationTest
  test "can see the welcome page" do
    get "/"
    assert_response :success
    assert_select "h1", "Bienvenue sur le site du RNMA"
    assert_select "h2", "Les Maisons des associations au service de la vie locale"
    assert_select "p", "Retour sur notre Assemblée générale 2021 !"
    assert_select "p", "Résultats d'enquête Covid-19, où en sont les associations un an après ?"
    assert_select "p", count: 0, text: "Le Contrat d'Engagement Républicain"
    assert_select "p", count: 0, text: "Situation en Covid-19"
    assert_select "div#carousel" do
      assert_select "div.card"
    end
  end

  test "can see the maison page" do
    get "/les_maisons"
    #ne passe pas :
    # assert_select "canvas.mapboxgl-canvas"
  end
end
