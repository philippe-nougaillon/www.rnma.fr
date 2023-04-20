require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase

  setup do
    visit root_path
  end

  test "visiting the index" do
    assert_selector "h1", text: "Bienvenue sur le site du RNMA"
    # TODO : VÉRIFIER TOUS LES BLOCS

    # vérifie qu'il y a les bonnes actualités d'affiché
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

  test "show all posts" do
    click_on "Toutes les actualités"
    assert_selector "h1", text: "Nos Actualités"
    assert_selector "p", text: "Retour sur notre Assemblée générale 2021 !"
    assert_selector "p", text: "Résultats d'enquête Covid-19, où en sont les associations un an après ?"
    assert_no_selector "p", text: "Le Contrat d'Engagement Républicain"
    assert_no_selector "p", text: "Situation en Covid-19"
  end

  test "show all events" do
    click_on "Tous les événements"
    assert_selector "h1", text: "L'Agenda"
    assert_selector "p", text: "Web-conférence Collectivités et accompagnement des associations"
    assert_selector "p", text: "Webinaire évaluation des Conseils Citoyens"
    assert_no_selector "p", text: "Formation OLVA - Animer sa démarche d'observation"
    assert_no_selector "p", text: "Assemblée générale ordinaire et extraordinaire du RNMA"
  end

  test "visit reseau" do
    click_on "reseau_footer"
    assert_selector "h1", text: "Le RNMA, une FABRIQUE de COMMUNS"
  end

  test "visit maisons" do
    click_on "maisons_footer"
    assert_selector "h1", text: "Les Maisons des Associations"
    # TODO : VÉRIFIER LA CARTE (L'ID DE LA CARTE QUAND ELLE S'AFFICHE, PAS SON PARENT (FAUDRA SUREMENT UN SLEEP()))
  end

  test "visit projets" do
    click_on "projets_footer"
    assert_selector "h1", text: "Nos Projets"
  end

  test "visit actualites" do
    click_on "actualite_footer"
    assert_selector "h1", text: "Nos Actualités"
  end

  test "visit agenda" do
    click_on "agenda_footer"
    assert_selector "h1", text: "L'Agenda"
  end

  test "visit ressources" do
    click_on "ressources_footer"
    assert_selector "h1", text: "Centre de Ressources"
  end

  test "visit connexion" do
    click_on "Connexion"
    assert_selector "h1", text: "Connexion"
  end

  test "visit recherche" do
    click_on "research"
    assert_selector "h1", text: "Rechercher"
  end

  test "visit confidentialite" do
    click_on "Politique de confidentialité"
    assert_selector "h1", text: "Politique de confidentialité"
  end

  test "visiting the member space" do
    login_user_member
    assert_selector "h1", text: "Espace membres du RNMA"
  end

  test "visit Déconnexion" do
    login_user_member
    click_on "Déconnexion"
    assert_selector "h1", text: "Bienvenue sur le site du RNMA"
  end

end
