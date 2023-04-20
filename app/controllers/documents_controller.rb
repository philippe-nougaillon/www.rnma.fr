class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ destroy ]
  
  def destroy
    @adhesion = @document.adhesion
    @document.destroy
    redirect_to @adhesion, notice: "Document détruit."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

end