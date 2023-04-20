class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_message, only: %i[ show edit update destroy repondre traiter reorienter archiver]
  before_action :is_user_authorized

  layout :determine_layout

  # GET /messages or /messages.json
  def index
    @messages = Message.all

    unless params[:search].blank?
      s = "%#{params[:search].upcase}%"
      @messages = @messages.where('messages.nom ILIKE :search OR messages.structure ILIKE :search OR messages.email ILIKE :search OR messages.message ILIKE :search', {search: s})
    end

    unless params[:state].blank?
      @messages = @messages.where("messages.workflow_state = ?", params[:state].to_s.downcase)
    end

    unless params[:tagged_with].blank?
      @messages = @messages.tagged_with(params[:tagged_with])
    end

    
    respond_to do |format|
      format.html do 
        @messages = @messages.page(params[:page])
      end

      format.xls do
        book = MessagesToXls.new(@messages).call
        file_contents = StringIO.new
        book.write file_contents # => Now file_contents contains the rendered file output
        filename = 'RNMA_Export-Messages.xls'
        send_data file_contents.string.force_encoding('binary'), filename: filename 
      end
    end
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    if verify_recaptcha
      @message = Message.new(message_params)

      if ((params[:message][:message].length < 50) && (params[:message][:message].count(' ') == 0))
        sleep 60
        redirect_to root_path, alert:"Il semble que vous ayez été pris.e pour un robot, si ce n'est pas le cas, veuillez contacter un membre du RNMA"
      else
        respond_to do |format|
          if @message.save
            # Envoyer une notification pour l'arrivée d'un nouveau message de contact
            mailer_response = MessageMailer.with(message: @message).notification.deliver_now
            MailLog.create(from: "Système", message_id: mailer_response.message_id, to: 'contact.rnma@maisonsdesassociations.fr', subject: "Nouveau message")

            mailer_response = MessageMailer.with(message: @message).notification_contact.deliver_now
            MailLog.create(from: "Système", message_id: mailer_response.message_id, to: @message.email, subject: "Message pris en compte")
        
            format.html { redirect_to root_path, notice: "Votre message a bien été pris en compte, et sera traité dans les meilleurs délais." }
            format.json { render :show, status: :created, location: @message }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @message.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      redirect_to root_url, alert: "Problème avec le captcha..."
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message modifié." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message détruit." }
      format.json { head :no_content }
    end
  end

  # WORKFLOW

  def traiter
    @message.traiter!
    redirect_to @message, notice: "Message modifié. État passé à 'traité'."
  end

  def archiver
    @message.archiver!
    redirect_to @message, notice: "Message modifié. État passé à 'archivé'."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:nom, :prénom, :structure, :email, :téléphone, :message, :tag_list)
    end

    def determine_layout
      'front' unless user_signed_in?
    end

    def is_user_authorized
      authorize Message
    end
end
