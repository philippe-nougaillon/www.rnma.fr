class EvenementsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_evenement, only: %i[ show edit update destroy publier promouvoir archiver duplicate]
  before_action :is_user_authorized, except: %i[ show ]

  layout :determine_layout

  # GET /evenements or /evenements.json
  def index
    @evenements = Evenement.all

    unless params[:search].blank?
      @evenements = @evenements.where('evenements.titre ILIKE :search OR evenements.chapeau ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    unless params[:state].blank?
      @evenements = @evenements.where("evenements.workflow_state = ?", params[:state].to_s.downcase)
    end

    @evenements = @evenements.reorder('evenements.' + sort_column + ' ' + sort_direction)
    @evenements = @evenements.page(params[:page])
  end

  # GET /evenements/1 or /evenements/1.json
  def show
    authorize @evenement
  end

  # GET /evenements/new
  def new
    @evenement = Evenement.new
  end

  # GET /evenements/1/edit
  def edit
  end

  # POST /evenements or /evenements.json
  def create
    @evenement = Evenement.new(evenement_params)

    respond_to do |format|
      if @evenement.save
        format.html { redirect_to @evenement, notice: "Évènement créé." }
        format.json { render :show, status: :created, location: @evenement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @evenement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evenements/1 or /evenements/1.json
  def update
    respond_to do |format|
      if @evenement.update(evenement_params)
        format.html { redirect_to @evenement, notice: "Évènement modifié." }
        format.json { render :show, status: :ok, location: @evenement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @evenement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evenements/1 or /evenements/1.json
  def destroy
    @evenement.destroy
    respond_to do |format|
      format.html { redirect_to evenements_url, notice: "Évènement détruit." }
      format.json { head :no_content }
    end
  end

  def duplicate
    @new_evenement = @evenement.dup
    @new_evenement.workflow_state = "nouveau"
    @new_evenement.save
    redirect_to evenements_url, notice: "Évènement dupliqué."
  end

  # WORKFLOW

  def publier
    @evenement.publier!
    redirect_to @evenement, notice: 'Evénement publié.'
  end

  def promouvoir
    @evenement.promouvoir!
    redirect_to @evenement, notice: 'Evénement promu.'
  end

  def archiver
    @evenement.archiver!
    redirect_to @evenement, notice: 'Evénement archivé.'
  end

  # ACTIVE_STORAGE
  
  def delete_image_attachment
    @evenement = Evenement.friendly.find(params[:id])
    @evenement.photo.purge
    redirect_to @evenement, notice: 'Photo de l\'évènement supprimée.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evenement
      @evenement = Evenement.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def evenement_params
      params.require(:evenement).permit(:debut, :fin, :lieu, :titre, :chapeau, :photo, :contenu, :membres, :poids, :publique)
    end

    def sort_column
      Evenement.column_names.include?(params[:sort]) ? params[:sort] : 'updated_at'
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def determine_layout
      'front' unless user_signed_in?
    end

    def is_user_authorized
      authorize Evenement
    end

end
