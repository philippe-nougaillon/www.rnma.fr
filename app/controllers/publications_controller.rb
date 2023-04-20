class PublicationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_publication, only: %i[ show edit update destroy publier archiver]
  before_action :is_user_authorized

  layout :determine_layout

  # GET /publications or /publications.json
  def index
    @publications = Publication.all

    unless params[:search].blank?
      @publications = @publications.where('publications.titre ILIKE :search OR publications.chapeau ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    @publications = @publications.page(params[:page])
  end

  # GET /publications/1 or /publications/1.json
  def show
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications or /publications.json
  def create
    @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: "Publication créée." }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1 or /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: "Publication modifiée." }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1 or /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url, notice: "Publication détruite." }
      format.json { head :no_content }
    end
  end

  # WORKFLOW

  def publier
    @publication.publier!
    redirect_to @publication, notice: 'Publication publiée.'
  end

  def archiver
    @publication.archiver!
    redirect_to @publication, notice: 'Publication archivée.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publication_params
      params.require(:publication).permit(:titre, :chapeau, :photo, :document, :contenu, :slug)
    end

    def determine_layout
      'front' unless user_signed_in?
    end

    def is_user_authorized
      authorize Publication
    end
end
