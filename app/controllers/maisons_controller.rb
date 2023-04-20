class MaisonsController < ApplicationController
  before_action :set_maison, only: %i[ show edit update destroy ]
  before_action :is_user_authorized, except: %i[ edit update ]
  helper_method :sort_column, :sort_direction

  # GET /maisons or /maisons.json
  def index
    @maisons = Maison.all

    unless params[:search].blank?
      @maisons = @maisons.where('maisons.nom ILIKE :search OR maisons.ville ILIKE :search OR maisons.region_name ILIKE :search', {search: "%#{params[:search].upcase}%"})
      # TODO : .joins(:action_text_rich_text)
    end

    unless params[:state].blank?
      @maisons = @maisons.where(region_name: params[:state])
    end

    unless params[:archivées].blank?
      @maisons = Maison.unscoped.joins(:adhesion).where("adhesions.workflow_state = 'archivée'").order('maisons.id DESC')
    end

    @maisons = @maisons.reorder(Arel.sql("#{sort_column} #{sort_direction}"))

    respond_to do |format|
      format.html do 
        @maisons = @maisons.page(params[:page])
      end

      format.xls do
        book = MaisonsToXls.new(@maisons).call
        file_contents = StringIO.new
        book.write file_contents # => Now file_contents contains the rendered file output
        filename = 'RNMA_Export-Maisons.xls'
        send_data file_contents.string.force_encoding('binary'), filename: filename 
      end

      format.json
    end

  end

  # GET /maisons/1 or /maisons/1.json
  def show
  end

  # GET /maisons/new
  def new
    @maison = Maison.new
  end

  # GET /maisons/1/edit
  def edit
    authorize @maison
  end

  # POST /maisons or /maisons.json
  def create
    @maison = Maison.new(maison_params)

    respond_to do |format|
      if @maison.save
        format.html { redirect_to @maison, notice: "Maison créée." }
        format.json { render :show, status: :created, location: @maison }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @maison.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maisons/1 or /maisons/1.json
  def update
    authorize @maison

    respond_to do |format|
      if @maison.update(maison_params)
        format.html do
          if current_user.admin?
            redirect_to @maison, notice: "Maison modifiée."
          else
            redirect_to membres_maison_path(id: @maison.id)
          end
        end 
        format.json { render :show, status: :ok, location: @maison }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @maison.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maisons/1 or /maisons/1.json
  def destroy
    @maison.destroy
    respond_to do |format|
      format.html { redirect_to maisons_url, notice: "Maison détruite." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maison
      @maison = Maison.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def maison_params
      params.require(:maison).permit(:nom, :type_structure, :adresse, :cp, :ville, :téléphone, :email, :latitude, :longitude, :description, :site, :corps, :logo, :facebook, :twitter, :linkedin, :youtube, :newsletter, :instagram,
                                      contacts_attributes: [:id, :nom, :prénom, :fonction, :téléphone, :email, :mobile, :adresse, :ville, :cp, :tag_list, :mémo])
    end

    def sortable_columns
      %w{maisons.id maisons.nom maisons.type_structure maisons.ville maisons.region_name maisons.updated_at}
    end

    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : 'maisons.updated_at'
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def is_user_authorized
      authorize Maison
    end

end
