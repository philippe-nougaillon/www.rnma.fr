class TypologiesController < ApplicationController
  before_action :set_typology, only: %i[ show edit update destroy ]
  before_action :is_user_authorized

  # GET /typologies or /typologies.json
  def index
    @typologies = Typology.all
  end

  # GET /typologies/1 or /typologies/1.json
  def show
  end

  # GET /typologies/new
  def new
    @typology = Typology.new
  end

  # GET /typologies/1/edit
  def edit
  end

  # POST /typologies or /typologies.json
  def create
    @typology = Typology.new(typology_params)

    respond_to do |format|
      if @typology.save
        format.html { redirect_to @typology, notice: "Typologie créée." }
        format.json { render :show, status: :created, location: @typology }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @typology.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /typologies/1 or /typologies/1.json
  def update
    respond_to do |format|
      if @typology.update(typology_params)
        format.html { redirect_to @typology, notice: "Typologie modifiée." }
        format.json { render :show, status: :ok, location: @typology }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @typology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /typologies/1 or /typologies/1.json
  def destroy
    @typology.destroy
    respond_to do |format|
      format.html { redirect_to typologies_url, notice: "Typologie détruite." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_typology
      @typology = Typology.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def typology_params
      params.require(:typology).permit(:nom)
    end

    def is_user_authorized
      authorize Typology
    end
end
