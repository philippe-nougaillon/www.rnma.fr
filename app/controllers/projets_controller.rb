class ProjetsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_projet, only: %i[ show edit update destroy publier archiver]
  before_action :is_user_authorized

  layout :determine_layout

  # GET /projets or /projets.json
  def index
    @projets = Projet.all

    unless params[:search].blank?
      @projets = @projets.where('projets.titre ILIKE :search OR projets.chapeau ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    @projets = @projets.page(params[:page])
  end

  # GET /projets/1 or /projets/1.json
  def show
  end

  # GET /projets/new
  def new
    @projet = Projet.new
  end

  # GET /projets/1/edit
  def edit
  end

  # POST /projets or /projets.json
  def create
    @projet = Projet.new(projet_params)

    respond_to do |format|
      if @projet.save
        format.html { redirect_to @projet, notice: "Projet(Action) créée." }
        format.json { render :show, status: :created, location: @projet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @projet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projets/1 or /projets/1.json
  def update
    respond_to do |format|
      if @projet.update(projet_params)
        format.html { redirect_to @projet, notice: "Projet(Action) modifiée." }
        format.json { render :show, status: :ok, location: @projet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @projet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projets/1 or /projets/1.json
  def destroy
    @projet.destroy
    respond_to do |format|
      format.html { redirect_to projets_url, notice: "Projet(Action) détruite." }
      format.json { head :no_content }
    end
  end

  def publier
    @projet.publier!
    redirect_to @projet, notice: 'Projet(Action) publiée.'
  end

  def archiver
    @projet.archiver!
    redirect_to @projet, notice: 'Projet(Action) archivée.'
  end

  # ACTIVE_STORAGE

  def delete_photo_attachment
    @projet = Projet.friendly.find(params[:id])
    @projet.photo.purge
    redirect_to @projet, notice: 'Photo du Projet(Action) supprimée.'
  end

  def delete_document_attachment
    @projet = Projet.friendly.find(params[:id])
    @projet.document.purge
    redirect_to @projet, notice: 'Document du Projet(Action) supprimé.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projet
      @projet = Projet.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def projet_params
      params.require(:projet).permit(:titre, :chapeau, :thème, :photo, :document, :contenu, :workflow_state, :slug, :poids)
    end

    def determine_layout
      'front' unless user_signed_in?
    end

    def is_user_authorized
      authorize Projet
    end

end
