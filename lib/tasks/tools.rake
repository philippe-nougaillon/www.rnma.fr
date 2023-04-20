namespace :tools do

    desc "Régénérer tous les index de recherche PG search"
    task reindex: :environment do
        PgSearch::Multisearch.rebuild(Post)
        PgSearch::Multisearch.rebuild(Evenement)
        PgSearch::Multisearch.rebuild(Maison)
        PgSearch::Multisearch.rebuild(Partenaire)
        PgSearch::Multisearch.rebuild(Publication)
        PgSearch::Multisearch.rebuild(Ressource)
    end

end  