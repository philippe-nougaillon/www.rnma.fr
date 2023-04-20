class PartenairesController < ApplicationController
  before_action :set_partenaire, only: %i[ show edit update destroy ]
  before_action :is_user_authorized

  # GET /partenaires or /partenaires.json
  def index
    @partenaires = Partenaire.all

    unless params[:search].blank?
      @partenaires = @partenaires.where('partenaires.nom ILIKE ?', "%#{params[:search].upcase}%")
    end

    unless params[:state].blank?
      @partenaires = @partenaires.where("partenaires.type_partenaire = ?", params[:state])
    end

    @partenaires = @partenaires.page(params[:page])
  end

  # GET /partenaires/1 or /partenaires/1.json
  def show
  end

  # GET /partenaires/new
  def new
    @partenaire = Partenaire.new
  end

  # GET /partenaires/1/edit
  def edit
  end

  # POST /partenaires or /partenaires.json
  def create
    @partenaire = Partenaire.new(partenaire_params)

    respond_to do |format|
      if @partenaire.save
        format.html { redirect_to @partenaire, notice: "Partenaire créé." }
        format.json { render :show, status: :created, location: @partenaire }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @partenaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /partenaires/1 or /partenaires/1.json
  def update
    respond_to do |format|
      if @partenaire.update(partenaire_params)
        format.html { redirect_to @partenaire, notice: "Partenaire modifié." }
        format.json { render :show, status: :ok, location: @partenaire }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @partenaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partenaires/1 or /partenaires/1.json
  def destroy
    @partenaire.destroy
    respond_to do |format|
      format.html { redirect_to partenaires_url, notice: "Partenaire détruit." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partenaire
      @partenaire = Partenaire.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def partenaire_params
      params.require(:partenaire).permit(:nom, :type_partenaire, :lien, :logo, :description, :poids)
    end

    def is_user_authorized
      authorize Partenaire
    end
end
