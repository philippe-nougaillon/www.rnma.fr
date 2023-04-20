class AdhesionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_adhesion, only: %i[ show edit update destroy complet valider resilier archiver renouveler]
  before_action :is_user_authorized
  helper_method :sort_column, :sort_direction
  
  # GET /adhesions or /adhesions.json
  def index
    @adhesions = Adhesion.all

    unless params[:search].blank?
      @adhesions = @adhesions.where('adhesions.organisme ILIKE :search OR adhesions.ville ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    unless params[:state].blank?
      @adhesions = @adhesions.where("adhesions.workflow_state = ?", params[:state].to_s.downcase)
    end

    unless params[:tagged_with].blank?
      @adhesions = @adhesions.tagged_with(params[:tagged_with])
    end

    @adhesions = @adhesions.joins('LEFT JOIN maisons ON adhesions.maison_id = maisons.id')
                            .reorder(Arel.sql("#{sort_column} #{sort_direction}"))
                            .page(params[:page])
  end

  # GET /adhesions/1 or /adhesions/1.json
  def show
  end

  # GET /adhesions/new
  def new
    @adhesion = Adhesion.new
  end

  # GET /adhesions/1/edit
  def edit
  end

  # POST /adhesions or /adhesions.json
  def create
    @adhesion = Adhesion.new(adhesion_params)

    respond_to do |format|
      if @adhesion.save
        format.html do 
          if user_signed_in? 
            redirect_to adhesions_path, notice: "Demande d'Adhésion créée avec succès."
          else
            redirect_to root_path, notice: "Demande d'Adhésion créée avec succès. Votre demande est maintenant en attente d'approbation du RNMA. À bientôt."
          end
        end
        format.json { render :show, status: :created, location: @adhesion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @adhesion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adhesions/1 or /adhesions/1.json
  def update
    respond_to do |format|
      if @adhesion.update(adhesion_params)
        format.html { redirect_to @adhesion, notice: "Adhésion modifiée." }
        format.json { render :show, status: :ok, location: @adhesion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @adhesion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adhesions/1 or /adhesions/1.json
  def destroy
    @adhesion.destroy
    respond_to do |format|
      format.html { redirect_to adhesions_url, notice: "Adhésion détruite." }
      format.json { head :no_content }
    end
  end

  #
  # Workflow Events
  # 

  def complet
    @adhesion.complet!
    redirect_to @adhesion, notice: 'Adhésion complète'
  end  

  def valider
    # créer la maison/le contact et l'action
    maison  = Maison.create(nom: @adhesion.organisme, type_structure: @adhesion.type_structure, adresse: @adhesion.adresse, cp: @adhesion.cp, ville: @adhesion.ville)
    contact = maison.contacts.new(nom: @adhesion.nom, prénom: @adhesion.prénom, fonction: @adhesion.fonction, adresse: @adhesion.adresse, cp: @adhesion.cp, ville: @adhesion.ville, téléphone: @adhesion.téléphone, email: @adhesion.email)

    # Vérifier qu'il n'y a pas déjà un contact ayant le même email
    if doublon = Contact.find_by(email: @adhesion.email)
      # Marquer les deux contacts avec le tag 'conflit'
      contact.tag_list.add('Conflit')
      doublon.tag_list.add('Conflit')
      doublon.save 
    end
    contact.save

    action = contact.actions.create(intitulé: 'Adhésion', mémo: "Demande d'adhésion validée.", user: current_user, fait: true)

    # Associer l'adhésion à la maison créée
    @adhesion.update(maison_id: maison.id)

    # Passer à l'état Valider
    @adhesion.valider!

    # Ajouter une cotisation
    @adhesion.cotisations.create(période: Date.today.year)

    redirect_to @adhesion, notice: 'Adhésion validée. Maison/Contact/Action/Cotisation créés.'
  end

  def activer
    @adhesion.activer!
    redirect_to @adhesion, notice: 'Adhésion activée.'
  end

  def resilier
    @adhesion.résilier!
    redirect_to @adhesion, notice: 'Adhésion résiliée.'
  end

  def archiver
    @adhesion.maison.contacts.each do |contact|
      contact.tag_list.remove("Membre")
      contact.save
    end
    @adhesion.maison.users.each do |user|
      user.destroy
    end
    @adhesion.archiver!
    redirect_to @adhesion, notice: 'Adhésion archivée.'
  end

  def renouveler
    @adhesion.renouveler!
    redirect_to @adhesion, notice: 'Adhésion renouvelée'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adhesion
      @adhesion = Adhesion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def adhesion_params
      # params.require(:adhesion).permit(:maison_id, :organisme, :type_structure, :adresse, :cp, :ville, :nom, :prénom, :fonction, :téléphone, :email, :workflow_state, documents: [])
      params.require(:adhesion).permit(:maison_id, :organisme, :type_structure, :adresse, :cp, :ville, :nom, :prénom, :fonction, :téléphone, :email, :workflow_state, :doc_1, :doc_2, :doc_3, :doc_4, :doc_5, :doc_6,
                                        documents_attributes: [:id, :fichier, :_destroy])
    end

    def sortable_columns
      %w{adhesions.id maisons.nom adhesions.organisme adhesions.type_structure adhesions.cp adhesions. adhesions.ville adhesions.nom adhesions.workflow_state adhesions.updated_at}
    end

    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : 'adhesions.updated_at'
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def is_user_authorized
      authorize Adhesion
    end

end
