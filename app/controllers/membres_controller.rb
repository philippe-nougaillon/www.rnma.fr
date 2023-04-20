class MembresController < ApplicationController

  layout 'front'

  def index
    @posts = Post.publié
    # @evenements = Evenement.publié.where(membres: true).where('DATE(evenements.fin) >= ?', Date.today).reorder(:poids).limit(3)
    @evenements = Evenement.publié
                            .where(publique: true)
                            .where('DATE(evenements.fin) >= ?', Date.today)
                            .reorder(:poids)
                            .limit(3)
    @images = SlideshowImage.where(membres: true)
    ressource_ids = MaisonsRessource.where(maison_id: current_user.mda.try(:id)).pluck(:ressource_id)
    @ressources = Ressource.where(id: ressource_ids).publiée.limit(3)
  end

  def maison
    if params[:id]
      @maison = Maison.find(params[:id])
    else
      @maison = current_user.mda
    end
    @contacts = @maison.contacts
  end

  def espace_personnel
    posts_ids = []
    Post.where(type_actu: 1).each do |post|
      posts_ids << post.id if post.audits.first.user == current_user
    end
    @posts = Post.where(id: posts_ids)

    # ressources_ids = []
    # Ressource.all.each do |ressource|
    #   ressources_ids << ressource.id if ressource.audits.first.user == current_user
    # end
    # @ressources = Ressource.where(id: ressources_ids)
  end
end
