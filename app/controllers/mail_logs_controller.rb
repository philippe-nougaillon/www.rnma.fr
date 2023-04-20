class MailLogsController < ApplicationController
  before_action :set_mail_log, only: %i[ show edit update destroy ]
  before_action :is_user_authorized

  # GET /mail_logs or /mail_logs.json
  def index
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"], 'api.eu.mailgun.net'
    domain = ENV["MAILGUN_DOMAIN"]
    @results_opened = mg_client.get("#{domain}/events", {:event => 'opened'}).to_h
    @results_failed = mg_client.get("#{domain}/events", {:event => 'failed'}).to_h

    @mail_logs = MailLog.all

    unless params[:search].blank?
      @mail_logs = @mail_logs.where('mail_logs.from ILIKE :search OR mail_logs.to ILIKE :search OR mail_logs.subject ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    @mail_logs = @mail_logs.reorder('mail_logs.' + sort_column + ' ' + sort_direction)
    @mail_logs = @mail_logs.page(params[:page])
  end

  # GET /mail_logs/1 or /mail_logs/1.json
  def show
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"], 'api.eu.mailgun.net'
    domain = ENV["MAILGUN_DOMAIN"]
    @results = mg_client.get("#{domain}/events", {:event => 'failed'}).to_h
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_log
      @mail_log = MailLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mail_log_params
      params.require(:mail_log).permit(:from, :to, :subject, :message_id)
    end

    def sort_column
      MailLog.column_names.include?(params[:sort]) ? params[:sort] : 'updated_at'
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def is_user_authorized
      authorize MailLog
    end
end
