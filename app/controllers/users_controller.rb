class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :accepter, :refuser]

  def index
    authorize User

    @users = User.all

    unless params[:search].blank?
      @users = @users.where('users.email ILIKE ?', "%#{params[:search].upcase}%")
    end

    unless params[:state].blank?
      @users = @users.where("users.approved = ?", false)
    end

    unless params[:not_approved].blank?
      @users = @users.where(approved: false)
    end

    respond_to do |format|
      format.html do 
        @users = @users
                      .reorder(Arel.sql('users.' + sort_column + ' ' + sort_direction))
                      .page(params[:page])
      end

      # format.xls do
      #   book = User.to_xls(@users)
      #   file_contents = StringIO.new
      #   book.write file_contents # => Now file_contents contains the rendered file output
      #   filename = "utilisateurs.xls"
      #   send_data file_contents.string.force_encoding('binary'), filename: filename 
      # end
    end

  end

  def show
    authorize User
  end
    
  def new
    authorize User
    
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  # POST /users
  # POST /users.json
  def create
    authorize User

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Utilisateur créé.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize @user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Utilisateur modifié.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize @user
    
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Utilisateur détruit.' }
      format.json { head :no_content }
    end
  end

  def accepter
    @user.approved = true
    @user.save
    mailer_response = AdminMailer.with(user: @user).user_approved.deliver_now
    MailLog.create(from: current_user.email, message_id: mailer_response.message_id, to: @user.email, subject: "Utilisateur accepté")

    # Ajouter le nouvel utilisateur à la liste des contacts
    contact = Contact.new(nom: @user.nom, prénom: @user.prénom, email: @user.email, mobile: @user.mobile, maison_id: @user.maison_id, tag_list: "Membre")
    contact.save if contact.valid?

    redirect_to users_path, notice: "Demande acceptée. Utilisateur informé par mail. #{contact.persisted? ? 'Contact créé.' : 'Contact NON CRÉÉ (déjà existant) !!!'}" 
  end

  def refuser
    mailer_response = AdminMailer.with(user: @user).user_not_approved.deliver_now
    MailLog.create(from: current_user.email, message_id: mailer_response.message_id, to: @user.email, subject: "Utilisateur refusé")
    @user.destroy
    redirect_to users_path, notice: 'Demande refusée. Utilisateur informé par mail, et supprimé de la BDD.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:nom, :prénom, :email, :fonction, :maison_id, :mobile, :photo, :poids, :password, :password_confirmation, :approved, :admin)
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

end
