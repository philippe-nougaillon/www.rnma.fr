class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy]
  skip_before_action :authenticate_user!, only: [:unsubscribe]
  before_action :is_user_authorized
  helper_method :sort_column, :sort_direction

  # GET /contacts or /contacts.json
  def index
    @contacts = Contact.all

    unless params[:search].blank?
      s = "%#{params[:search].upcase}%"
      @contacts = Contact.joins('LEFT JOIN maisons ON contacts.maison_id = maisons.id')
                         .where('maisons.nom ILIKE :search OR maisons.region_name ILIKE :search OR contacts.organisation ILIKE :search OR contacts.nom ILIKE :search OR contacts.fonction ILIKE :search OR contacts.ville ILIKE :search OR contacts.email ILIKE :search',
                               {search: s})
    end

    unless params[:state].blank?
      @contacts = @contacts.tagged_with(params[:state])
    end

    unless params[:abonnés].blank?
      @contacts = @contacts.abonné
    end

    @contacts = @contacts.joins('LEFT JOIN maisons ON contacts.maison_id = maisons.id').reorder(Arel.sql("#{sort_column} #{sort_direction}"))

    respond_to do |format|
      format.html do 
        @contacts = @contacts
                        .page(params[:page])
      end

      format.xls do
        book = ContactsToXls.new(@contacts).call
        file_contents = StringIO.new
        book.write file_contents # => Now file_contents contains the rendered file output
        filename = 'RNMA_Export-Contacts.xls'
        send_data file_contents.string.force_encoding('binary'), filename: filename 
      end

      format.vcf do
        vcards = ContactsToVcf.new(@contacts).call
        file_contents = StringIO.new
        file_contents.puts vcards
        filename = 'RNMA_Export-Contacts.vcf'
        send_data file_contents.string.force_encoding('binary'), filename: filename
      end
    end

  end

  # GET /contacts/1 or /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @contact.organisation = params[:organisation]
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: "Contact créé." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: "Contact modifié." }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: "Contact détruit." }
      format.json { head :no_content }
    end
  end

  def action
    @contacts_id = params[:contacts_id].keys
    @action_name = params[:action_name]
  end

  def do_action
    if params[:action_name] == 'Supprimer' && params[:confirmation]
      params[:ids].split(' ').each do | id |
        begin
          Contact.find(id).destroy
        rescue
          flash[:alert] = "Suppression impossible ! Le contact a des actions !"
        else
          flash[:notice] = "Contacts détruits."
        end
      end
    elsif params[:action_name] == 'Ajouter un tag'
      params[:ids].split(' ').each do | id |
        contact = Contact.find(id)
        contact.tag_list.add(params[:tag])
        contact.save
      end
      flash[:notice] = "Tag '#{ params[:tag] } ajouté."
    elsif params[:action_name] == 'Exporter'
      book = ContactsToXls.new(Contact.where(id: params[:ids].split(' '))).call
      file_contents = StringIO.new
      book.write file_contents # => Now file_contents contains the rendered file output
      filename = 'RNMA_Export-Contacts.xls'
      send_data file_contents.string.force_encoding('binary'), filename: filename 
      return
    end
    redirect_to contacts_path
  end

  def unsubscribe
    @contact = Contact.abonné.find_by(email: params[:contact_email])
    @contact.update(abonne: false)
    mailer_response = AdminMailer.with(contact: @contact).user_unsubscribed.deliver_now
    MailLog.create(from: "Système", message_id: mailer_response.message_id, to: User.testeurs.pluck(:email).join(', '), subject: "Contact désabonné")
    redirect_to root_url, notice: 'Votre demande de désabonnement a été prise en compte'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:maison_id, :organisation, :nom, :prénom, :fonction, :adresse, :cp, :ville, :téléphone, :mobile, :email, :mémo, :tag_list, :abonne,
                                      actions_attributes: [:id, :user_id, :intitulé, :mémo])
    end

    def sortable_columns
      %w{contacts.id contacts.nom contacts.prénom contacts.fonction maisons.nom contacts.organisation contacts.ville contacts.abonne contacts.updated_at}
    end
  
    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : 'contacts.updated_at'
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def is_user_authorized
      authorize Contact
    end
end
