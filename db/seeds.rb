# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# Evenement.create!([
#   {le: "2021-07-24", lieu: "en visio conférence", titre: "53èmes Rencontres nationales du RNMA - L'accompagnement de la vie associative sur les territoires", chapeau: "En 2021, les 53èmes Rencontres Nationales du RNMA seront l’occasion de célébrer l’anniversaire des 120 ans de la loi et de se projeter sur la place des associations sur nos territoires dans les années à l’avenir, au plus près de l’action des Maisons des associations et des tissus associatifs locaux."},
#   {le: "2021-07-15", lieu: "en visio conférence", titre: "[Web-conférence] Collectivités et accompagnement des associations", chapeau: "Web-conférence] Collectivités et accompagnement des associations en visio-conférence"}
#   ])

# Post.create!([
#   {titre: "Situation en Covid-19", chapeau: "Durant cette période, le RNMA reste mobilisé pour soutenir les points d'appui à la vie associative sur les territoires en leurs apportant de l'information actualisée sur les mesures en place pour le secteur associatif, des inventaires et démo d'outils pour maintenir le lien avec les associations, des partages de pratiques entre membres.", workflow_state: ""},
#   {titre: "[Résultats d'enquête] Covid-19, où en sont les associations un an après ?", chapeau: "Le Mouvement associatif, en partenariat avec le RNMA et Recherches & Solidarités, publie les résultats du troisième volet de l’enquête concernant les impacts de la crise sanitaire sur les associations. Retrouvez tous les résultats de cette 3ème enquête présentés à l'occasion d'un webinaire organisé le mardi 8 juin à 17h.", workflow_state: ""},
#   {titre: "Hommage à Marie Rouxel", chapeau: "Marie Rouxel militante associative depuis de très nombreuses années, ancienne directrice adjointe de l’AGLCA – maison des associations de Bourg-en-Bresse , fut à l’initiative avec une poignée d’autres responsables de MDA, de la création du Réseau National des Maisons des Associations - RNMA", workflow_state: ""},
#   {titre: "Retour sur notre Assemblée générale 2021 !", chapeau: "Malgré les circonstances liées à la crise sanitaire, le RNMA a fait le choix de maintenir cette année encore son Assemblée générale ordinaire à distance à la date prévue du 1e avril.", workflow_state: ""},
#   {titre: "ENQUETE #COVID-19 : où en sont les associations, un an après ?", chapeau: "La crise sanitaire impacte grandement l’activité des associations. En un an, à quel point la situation a-t-elle évoluée ? Comment les associations vivent-elles cette crise qui s'inscrit dans la durée ? Nous souhaitons pouvoir le mesurer, d’abord pour accompagner au mieux l'ensemble des associations mais aussi pour porter leur voix auprès des pouvoirs publics et aborder les perspectives.", workflow_state: ""}
# ])

# Ressource.create!([
#   {titre: "", chapeau: "", slug: "", description: ""}
# ])

# Publication.create!([
#   {titre: "", chapeau: "", thème: "", slug: ""}
# ])

Category.create!([
  {nom: 'Engagement et participation citoyenne'},
  {nom: 'Accompagnement'},
  {nom: 'Gestion des MDA'},
  {nom: 'Observation-OLVA'},
  {nom: 'Co-construction'},
  {nom: 'Développement local'}
])

Typology.create!([
  {nom: 'Cas pratiques-témoignages'},
  {nom: 'Analyses et théories'},
  {nom: 'Outils'}
])

Partenaire.create!([
  {
    nom: "CHORUM",
    type_partenaire: 1,
    lien: "http://www.chorum.fr/",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/4.png"
  },
  {
    nom: "Commissariat général à l'égalité des territoires",
    type_partenaire: 1,
    lien: "http://www.cget.gouv.fr/",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/26.png"
  },
  {
    nom: "Fondation Crédit Coopératif",
    type_partenaire: 1,
    lien: "https://fondation.credit-cooperatif.coop/",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/54.jpg"
  },
  {
    nom: "Fondation SNCF",
    type_partenaire: 1,
    lien: "https://www.fondation-sncf.org/fr/",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/28.jpg"
  },
  {
    nom: "Fonjep",
    type_partenaire: 1,
    lien: "http://www.fonjep.org/Accueil/Accueil.aspx",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/31.jpg"
  },
  {
    nom: "Maif",
    type_partenaire: 1,
    lien: "http://www.maif.fr/associationsetcollectivites/associations/accueil.html",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/22.png"
  },
  {
    nom: "Mairie de Paris",
    type_partenaire: 1,
    lien: "http://www.paris.fr/",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/30.jpg"
  },
  {
    nom: "Ministère de l'Education Nationale et de la Jeunesse",
    type_partenaire: 1,
    lien: "http://www.associations.gouv.fr/",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/53.png"
  },
  {
    nom: "Smacl",
    type_partenaire: 1,
    lien: "https://www.smacl.fr/",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/52.jpg"
  },
  {
    nom: "ADDES",
    type_partenaire: 2,
    lien: "http://addes.asso.fr/",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/50.png"
  },
  {
    nom: "Avise",
    type_partenaire: 2,
    lien: "http://www.avise.org/",
    description: ""
    #logo: "http://www.maisonsdesassociations.fr/uploads/partenaires/34.jpg"
  },
  {
    nom: "CNCRES",
    type_partenaire: 2,
    lien: "http://www.cncres.org/accueil_cncres",
    description: ""
   #logo: ""
  },
  {
    nom: "FONDA",
    type_partenaire: 2,
    lien: "http://www.fonda.asso.fr/",
    description: ""
   #logo: ""
  },
  {
    nom: "Fondation du Bénévolat",
    type_partenaire: 2,
    lien: "http://fondation-benevolat.fr/",
    description: ""
   #logo: ""
  },
  {
    nom: "France Bénévolat",
    type_partenaire: 2,
    lien: "http://www.francebenevolat.org/",
    description: ""
   #logo: ""
  },
  {
    nom: "INSEE",
    type_partenaire: 2,
    lien: "http://www.insee.fr/fr/",
    description: ""
   #logo: ""
  },
  {
    nom: "Le Mouvement Associatif",
    type_partenaire: 2,
    lien: "http://lemouvementassociatif.org/",
    description: ""
   #logo: ""
  },
  {
    nom: "UDES",
    type_partenaire: 2,
    lien: "http://www.udes.fr/",
    description: ""
   #logo: ""
  },
  {
    nom: "Association Mode d’Emploi",
    type_partenaire: 3,
    lien: "http://www.ame1901.fr/",
    description: ""
   #logo: ""
  },
  {
    nom: "Association pour le Développement Associatif - Adéma",
    type_partenaire: 3,
    lien: "http://www.management-associatif.org/",
    description: ""
   #logo: ""
  },
  {
    nom: "CAC",
    type_partenaire: 3,
    lien: "http://www.associations-citoyennes.net/",
    description: ""
   #logo: ""
  },
  {
    nom: "Carenews",
    type_partenaire: 3,
    lien: "https://www.carenews.com/",
    description: ""
   #logo: ""
  },
  {
    nom: "CNFPT",
    type_partenaire: 3,
    lien: "http://www.cnfpt.fr/",
    description: ""
   #logo: ""
  },
  {
    nom: "Collectif rivage",
    type_partenaire: 3,
    lien: "http://www.collectif-rivages.fr/",
    description: ""
   #logo: ""
  },
  {
    nom: "Kynos",
    type_partenaire: 3,
    lien: "http://kynos.info/",
    description: ""
   #logo: ""
  },
  {
    nom: "Laboratoire MATISSE",
    type_partenaire: 3,
    lien: "http://matisse.univ-paris1.fr/associations/",
    description: ""
   #logo: ""
  },
  {
    nom: "Le Rameau",
    type_partenaire: 3,
    lien: "http://www.lerameau.fr/",
    description: ""
   #logo: ""
  },
  {
    nom: "Portail des collectivités locales, territoriales, fonction publique territoriale",
    type_partenaire: 3,
    lien: "http://www.territorial.fr/",
    description: ""
   #logo: ""
  },
  {
    nom: "Recherches et Solidarités",
    type_partenaire: 3,
    lien: "http://www.recherches-solidarites.org/",
    description: ""
   #logo: ""
  },
  {
    nom: "Science Po Grenoble",
    type_partenaire: 3,
    lien: "http://www.sciencespo-grenoble.fr/",
    description: ""
   #logo: ""
  },

  
])
