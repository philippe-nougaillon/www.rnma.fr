class PagesController < ApplicationController
    skip_before_action :authenticate_user!

    layout 'front'

    def welcome
        @posts = Post.publié.where(membres: false)
        @evenements = Evenement.publié
                                .where(publique: true)
                                .where('DATE(evenements.fin) >= ?', Date.today)
                                .reorder(:poids, :debut)
                                .limit(3)
        @images = SlideshowImage.where(publique: true)
    end

    def posts
        @posts = Post.publié
        @posts = @posts.where(membres: false) unless user_signed_in?
        @posts = @posts.page(params[:page])
    end

    def evenements
        @evenements = Evenement.publié
        @evenements = @evenements.where('DATE(evenements.fin) >= ?', Date.today)
        # if user_signed_in?
        #     @evenements = @evenements.where(membres: true)
        # else
            @evenements = @evenements.where(publique: true)
        # end
        @evenements = @evenements.reorder('poids, debut')
        @evenements = @evenements.page(params[:page])
    end

    def maisons
        # Afficher que les maisons dont l'adhésion est validée
        @maisons = Maison.joins(:adhesion).where("adhesions.workflow_state = ?", :validée)
        @regions = @maisons.where.not(region_name: nil).pluck(:region_name).uniq.sort        
        @center = [2.407914616221202, 47.08362763879501]
        @zoom = request.variant.include?(:desktop) ? 5 : 4
        unless params[:state].blank?
            @maisons = @maisons.where(region_name: params[:state])
            if @maisons.where.not(latitude: nil).any? 
                maison = @maisons.where.not(latitude: nil).first
                @center = [maison.longitude, maison.latitude]
                @zoom = 7
            end
        end
    end

    def ressources
        @ressources = Ressource.publiée.page(params[:page])

        unless params[:categories_id].blank?
            ids =  params[:categories_id].keys 
            @ressources = @ressources.where(id: CategoriesRessource.where(category_id: ids).pluck(:ressource_id))
        end

        unless params[:typologies_id].blank?
            ids =  params[:typologies_id].keys 
            @ressources = @ressources.where(id: RessourcesTypology.where(typology_id: ids).pluck(:ressource_id))
        end

        unless params[:maisons_id].blank?
            ids = params[:maisons_id].keys
            @ressources = @ressources.where(id: MaisonsRessource.where(maison_id: ids).pluck(:ressource_id))
        end

        unless params[:tagged_with].blank?
            @ressources = @ressources.tagged_with(params[:tagged_with])
        end

        unless params[:search].blank?
            @ressources = @ressources.where('ressources.titre ILIKE :search OR ressources.chapeau ILIKE :search', {search: "%#{params[:search].upcase}%"})
        end
      
    end

    def publications
        @publications = Publication.publiée.page(params[:page])
    end

    def projets
        @projets = Projet.publié.page(params[:page])
    end

    def reseau
        @users_equipe = User.equipe
        @users_ca = User.ca
        @partenaires = Partenaire.all
    end

    def confidentialite
    end

    def recherche
        unless params[:search].blank?
            @results = PgSearch.multisearch("%#{ params[:search] }%")
            @results = @results.page(params[:page]).per(12)
        end
    end

    def newsletter
        @sibs = Sib.all.limit(10)
    end
end