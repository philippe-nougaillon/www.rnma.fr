require "mobile_system_test_case"

class PagesMobileTest < MobileSystemTestCase

  setup do
    visit root_path
  end

  test "visiting the index" do
    assert_selector "h1", text: "Bienvenue sur le site du RNMA"
    # TODO : VÉRIFIER TOUS LES BLOCS

    #vérifie qu'il y a les bonnes actualités d'affiché
    assert_selector "p", text: "Retour sur notre Assemblée générale 2021 !"
    assert_selector "p", text: "Résultats d'enquête Covid-19, où en sont les associations un an après ?"
    assert_no_selector "p", text: "Le Contrat d'Engagement Républicain"
    assert_no_selector "p", text: "Situation en Covid-19"

    #vérifie qu'il y a les bons évènements d'affiché
    assert_selector "p", text: "Web-conférence Collectivités et accompagnement des associations"
    assert_selector "p", text: "Webinaire évaluation des Conseils Citoyens"
    assert_no_selector "p", text: "Formation OLVA - Animer sa démarche d'observation"
    assert_no_selector "p", text: "Assemblée générale ordinaire et extraordinaire du RNMA"
  end
end