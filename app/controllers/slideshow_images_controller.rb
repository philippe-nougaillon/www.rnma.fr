class SlideshowImagesController < ApplicationController
  before_action :set_slideshow_image, only: %i[ show edit update destroy ]
  before_action :is_user_authorized

  # GET /slideshow_images or /slideshow_images.json
  def index
    @slideshow_images = SlideshowImage.all
  end

  # GET /slideshow_images/1 or /slideshow_images/1.json
  def show
  end

  # GET /slideshow_images/new
  def new
    @slideshow_image = SlideshowImage.new
  end

  # GET /slideshow_images/1/edit
  def edit
  end

  # POST /slideshow_images or /slideshow_images.json
  def create
    @slideshow_image = SlideshowImage.new(slideshow_image_params)

    respond_to do |format|
      if @slideshow_image.save
        format.html { redirect_to @slideshow_image, notice: "Image créée." }
        format.json { render :show, status: :created, location: @slideshow_image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @slideshow_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slideshow_images/1 or /slideshow_images/1.json
  def update
    respond_to do |format|
      if @slideshow_image.update(slideshow_image_params)
        format.html { redirect_to @slideshow_image, notice: "Image modifiée." }
        format.json { render :show, status: :ok, location: @slideshow_image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @slideshow_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slideshow_images/1 or /slideshow_images/1.json
  def destroy
    @slideshow_image.destroy
    respond_to do |format|
      format.html { redirect_to slideshow_images_url, notice: "Image détruite." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slideshow_image
      @slideshow_image = SlideshowImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slideshow_image_params
      params.require(:slideshow_image).permit(:titre, :poids, :image, :url, :membres, :publique)
    end

    def is_user_authorized
      authorize SlideshowImage
    end
end
