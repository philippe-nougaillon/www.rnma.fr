class CotisationsController < ApplicationController
  before_action :set_cotisation, only: %i[ show edit update destroy ]
  before_action :is_user_authorized
  helper_method :sort_column, :sort_direction

  # GET /cotisations or /cotisations.json
  def index
    @cotisations = Cotisation.all

    unless params[:search].blank?
      @cotisations = @cotisations.joins(:adhesion).joins(:maison).where('adhesions.organisme ILIKE :search OR cotisations.période ILIKE :search OR cotisations.mémo ILIKE :search OR maisons.ville ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    unless params[:state].blank?
      @cotisations = @cotisations.where("cotisations.workflow_state = ?", params[:state].to_s.downcase)
    end

    # Appliquer le tri
    @cotisations = @cotisations.joins(:maison).reorder(Arel.sql("#{sort_column} #{sort_direction}"))

    respond_to do |format|
      format.html do 
        @cotisations = @cotisations.page(params[:page])
      end

      format.xls do
        book = CotisationsToXls.new(@cotisations).call
        file_contents = StringIO.new
        book.write file_contents # => Now file_contents contains the rendered file output
        filename = 'RNMA_Export-Cotisations.xls'
        send_data file_contents.string.force_encoding('binary'), filename: filename 
      end
    end
  end

  # GET /cotisations/1 or /cotisations/1.json
  def show
  end

  # GET /cotisations/new
  def new
    @cotisation = Cotisation.new
    @cotisation.adhesion_id = params[:adhesion_id]
  end

  # GET /cotisations/1/edit
  def edit
  end

  # POST /cotisations or /cotisations.json
  def create
    @cotisation = Cotisation.new(cotisation_params)

    respond_to do |format|
      if @cotisation.save
        format.html { redirect_to @cotisation, notice: "Cotisation créée." }
        format.json { render :show, status: :created, location: @cotisation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cotisation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cotisations/1 or /cotisations/1.json
  def update
    respond_to do |format|
      if @cotisation.update(cotisation_params)
        format.html { redirect_to @cotisation, notice: "Cotisation modifiée." }
        format.json { render :show, status: :ok, location: @cotisation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cotisation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cotisations/1 or /cotisations/1.json
  def destroy
    @cotisation.destroy
    respond_to do |format|
      format.html { redirect_to cotisations_url, notice: "Cotisation détruite." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cotisation
      @cotisation = Cotisation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cotisation_params
      params.require(:cotisation).permit(:adhesion_id, :période, :montant, :date_échéance, :workflow_state, :mémo)
    end

    def sortable_columns
      %w{cotisations.id maisons.nom maisons.type_structure maisons.ville cotisations.période cotisations.montant cotisations.date_échéance cotisations.workflow_state cotisations.mémo cotisations.updated_at}
    end
  
    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : 'cotisations.updated_at'
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def is_user_authorized
      authorize Cotisation
    end

end
