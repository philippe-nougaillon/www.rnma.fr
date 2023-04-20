class RessourcesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_ressource, only: %i[ show edit update destroy valider publier partager promouvoir archiver ]
  before_action :is_user_authorized, except: %i[ show edit update]

  layout :determine_layout

  # GET /ressources or /ressources.json
  def index
    @ressources = Ressource.all

    unless params[:search].blank?
      @ressources = @ressources.joins(:action_text_rich_text)
                               .where('ressources.titre ILIKE :search OR ressources.chapeau ILIKE :search OR action_text_rich_texts.body ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    unless params[:state].blank?
      @ressources = @ressources.where("ressources.workflow_state = ?", params[:state].to_s.downcase)
    end

    unless params[:tagged_with].blank?
      @ressources = @ressources.tagged_with(params[:tagged_with])
    end

    @ressources = @ressources.page(params[:page])
  end

  # GET /ressources/1 or /ressources/1.json
  def show
    authorize @ressource
  end

  # GET /ressources/new
  def new
    @ressource = Ressource.new
  end

  # GET /ressources/1/edit
  def edit
    authorize @ressource
  end

  # POST /ressources or /ressources.json
  def create
    # on ne peut pas remplacer le block suivant avec @ressource = Ressource.new(ressource_params)
    # c'est dû au nested de stimulus
    @ressource = Ressource.new
    maj_maisons_attributes(@ressource)
    maj_categories_attributes(@ressource)
    maj_typologies_attributes(@ressource)
    @ressource.update(ressource_params)

    respond_to do |format|
      if @ressource.save
        if current_user.admin?
          format.html { redirect_to @ressource, notice: "Ressource créée." }
        else
          format.html { redirect_to @ressource, notice: "Votre ressource a bien été créée. Elle ne sera visible sur le site qu'après validation par un membre de l'équipe du RNMA." }
        end
        format.json { render :show, status: :created, location: @ressource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ressource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ressources/1 or /ressources/1.json
  def update
    authorize @ressource

    maj_maisons_attributes(@ressource)
    maj_categories_attributes(@ressource)
    maj_typologies_attributes(@ressource)

    respond_to do |format|
      if @ressource.update(ressource_params)
        format.html { redirect_to @ressource, notice: "Ressource modifiée." }
        format.json { render :show, status: :ok, location: @ressource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ressource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ressources/1 or /ressources/1.json
  def destroy
    @ressource.destroy
    respond_to do |format|
      format.html { redirect_to ressources_url, notice: "Ressource détruite." }
      format.json { head :no_content }
    end
  end

  # HABTM nested_form
  def maj_maisons_attributes(ressource)
    # supprimer tous les éléments liés
    ressource.maisons.destroy_all
    # recréer les éléments
    ressource_params[:maisons_attributes].to_h.values.uniq.each do | maison | 
      ressource.maisons << Maison.find(maison[:id]) unless maison[:id].blank?
    end
  end

  def maj_categories_attributes(ressource)
    # supprimer tous les éléments liés
    ressource.categories.destroy_all
    # recréer les éléments
    ressource_params[:categories_attributes].to_h.values.uniq.each do | category | 
      ressource.categories << Category.find(category[:id]) unless category[:id].blank?
    end
  end

  def maj_typologies_attributes(ressource)
    # supprimer tous les éléments liés
    ressource.typologies.destroy_all
    # recréer les éléments
    ressource_params[:typologies_attributes].to_h.values.uniq.each do | typology | 
      ressource.typologies << Typology.find(typology[:id]) unless typology[:id].blank?
    end
  end


  # Workflow
  def valider
    @ressource.valider!
    redirect_to @ressource, notice: 'Ressource validée'
  end

  def publier
    @ressource.publier!
    redirect_to @ressource, notice: 'Ressource publiée'
  end

  def partager
    @ressource.partager!
    redirect_to @ressource, notice: 'Ressource partagée'
  end

  def promouvoir
    @ressource.promouvoir!
    redirect_to @ressource, notice: 'Ressource promue'
  end

  def archiver
    @ressource.archiver!
    redirect_to @ressource, notice: 'Ressource archivée'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ressource
      @ressource = Ressource.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ressource_params
      params.require(:ressource)
            .permit(:titre, :chapeau, :description, :corps, :date_publication, :slug, :workflow_state, :tag_list, :membres,
                    documents: [], 
                    maisons_attributes: [:id, :_destroy],
                    categories_attributes: [:id, :_destroy],
                    typologies_attributes: [:id, :_destroy])
    end

    def determine_layout
      'front' unless user_signed_in?
    end

    def is_user_authorized
      authorize Ressource
    end

end
