class SibsController < ApplicationController
  before_action :set_sib, only: %i[ show edit update destroy ]

  # GET /sibs or /sibs.json
  def index
    @sibs = Sib.all
    
    unless params[:search].blank?
      @sibs = @sibs.where('sibs.intitulé ILIKE :search OR sibs.url ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    @sibs = @sibs.page(params[:page])
  end

  # GET /sibs/1 or /sibs/1.json
  def show
  end

  # GET /sibs/new
  def new
    @sib = Sib.new
  end

  # GET /sibs/1/edit
  def edit
  end

  # POST /sibs or /sibs.json
  def create
    @sib = Sib.new(sib_params)

    respond_to do |format|
      if @sib.save
        format.html { redirect_to sib_url(@sib), notice: "Archive SIB créée." }
        format.json { render :show, status: :created, location: @sib }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sib.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sibs/1 or /sibs/1.json
  def update
    respond_to do |format|
      if @sib.update(sib_params)
        format.html { redirect_to sib_url(@sib), notice: "Archive SIB modifiée." }
        format.json { render :show, status: :ok, location: @sib }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sib.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sibs/1 or /sibs/1.json
  def destroy
    @sib.destroy

    respond_to do |format|
      format.html { redirect_to sibs_url, notice: "Archive SIB supprimée." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sib
      @sib = Sib.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sib_params
      params.require(:sib).permit(:intitulé, :envoyée_le, :url)
    end
end
