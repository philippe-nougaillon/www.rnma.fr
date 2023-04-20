class ActionsController < ApplicationController
  before_action :set_action, only: %i[ show edit update destroy ]
  before_action :is_user_authorized
  helper_method :sort_column, :sort_direction

  # GET /actions or /actions.json
  def index
    @actions = Action.all

    unless params[:search].blank?
      @actions = @actions.joins('LEFT JOIN contacts ON actions.contact_id = contacts.id').where('contacts.nom ILIKE :search OR contacts.organisation ILIKE :search OR actions.intitulé ILIKE :search OR actions.mémo ILIKE :search', {search: "%#{params[:search].upcase}%"})
    end

    unless params[:state].blank?
      if params[:state] == 'A faire'
        @actions = @actions.where.not(fait: true).reorder('date_rappel')
      else
        @actions = @actions.where(fait: true)
      end
    end

    @actions = @actions
                        .joins('LEFT JOIN contacts ON actions.contact_id = contacts.id')
                        .joins('LEFT JOIN maisons ON contacts.maison_id = maisons.id')
                        .reorder(Arel.sql("#{sort_column} #{sort_direction}"))

    respond_to do |format|
      format.html do 
        @actions = @actions.page(params[:page])
      end

      format.xls do
        book = ActionsToXls.new(@actions).call
        file_contents = StringIO.new
        book.write file_contents # => Now file_contents contains the rendered file output
        filename = 'RNMA_Export-Actions.xls'
        send_data file_contents.string.force_encoding('binary'), filename: filename 
      end
    end

  end

  # GET /actions/1 or /actions/1.json
  def show
  end

  # GET /actions/new
  def new
    @action = Action.new
    @action.user = current_user
    @action.contact_id = params[:contact_id]
    @action.fait = true
  end

  # GET /actions/1/edit
  def edit
  end

  # POST /actions or /actions.json
  def create
    @action = Action.new(action_params)

    respond_to do |format|
      if @action.save
        format.html { redirect_to @action, notice: "Action créé." }
        format.json { render :show, status: :created, location: @action }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actions/1 or /actions/1.json
  def update
    respond_to do |format|
      if @action.update(action_params)
        format.html { redirect_to @action, notice: "Action modifiée." }
        format.json { render :show, status: :ok, location: @action }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actions/1 or /actions/1.json
  def destroy
    @action.destroy
    respond_to do |format|
      format.html { redirect_to actions_url, notice: "Action détruite." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_action
      @action = Action.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def action_params
      params.require(:contact_action).permit(:contact_id, :user_id, :intitulé, :mémo, :fait, :date_rappel)
    end

    def sortable_columns
      %w{actions.id contacts.nom maisons.nom actions.created_at actions.user_id actions.intitulé actions.fait actions.date_rappel actions.updated_at}
    end
  
    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : 'actions.updated_at'
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def is_user_authorized
      authorize Action
    end

end
