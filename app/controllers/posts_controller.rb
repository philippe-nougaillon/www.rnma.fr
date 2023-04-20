class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_post, only: %i[ show edit update destroy publier promouvoir archiver ]
  before_action :is_user_authorized, except: %i[ show edit update ]
  
  layout :determine_layout
  
  # GET /posts or /posts.json
  def index
    @posts = Post.all

    unless params[:search].blank?
      @posts = @posts.where('posts.titre ILIKE :search OR posts.chapeau ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    unless params[:state].blank?
      @posts = @posts.where("posts.workflow_state = ?", params[:state].to_s.downcase)
    end

    @posts = @posts.page(params[:page])
  end

  # GET /posts/1 or /posts/1.json
  def show
    authorize @post
    @posts = Post.where.not(id: @post.id).publié
    @posts = @posts.where(membres: false) unless user_signed_in?
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.type_actu = "Territoires" if current_user.membre?
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        if current_user.admin?
          format.html { redirect_to @post, notice: "Actualité créée." }
        else
          format.html { redirect_to @post, notice: "Votre actualité a bien été créée. Elle ne sera visible sur le site qu'après validation par un membre de l'équipe du RNMA." }
        end
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize @post

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Actualité modifiée." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Actualité détruite." }
      format.json { head :no_content }
    end
  end

  # WORKFLOW

  def publier
    @post.publier!
    redirect_to @post, notice: 'Actualité publiée.'
  end

  def promouvoir
    @post.promouvoir!
    redirect_to @post, notice: 'Actualité promue dans la newsletter.'
  end

  def archiver
    @post.archiver!
    redirect_to @post, notice: 'Actualité archivée.'
  end

  # ACTIVE_STORAGE
  
  def delete_vignette_attachment
    @post = Post.friendly.find(params[:id])
    @post.vignette.purge
    redirect_to @post, notice: 'Vignette de l\'actualité supprimée.'
  end

  def delete_poster_attachment
    @post = Post.friendly.find(params[:id])
    @post.poster.purge
    redirect_to @post, notice: 'Poster du l\'actualité supprimée.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:titre, :chapeau, :workflow_state, :vignette, :poster, :contenu, :membres, :type_actu, :created_at)
    end

    def determine_layout
      'front' unless user_signed_in?
    end

    def is_user_authorized
      authorize Post
    end
end
