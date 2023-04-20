class Cotisation < ApplicationRecord
  include Workflow
  include WorkflowActiverecord

  audited

  belongs_to :adhesion
  has_one :maison, through: :adhesion

  # WORKFLOW
  EN_COURS  = 'en_cours'
  ENGAGEE   = 'engagée'
  REGLEE    = 'réglée'
  IMPAYEE   = 'impayée'
  
  workflow do
    state EN_COURS, meta: { style: 'is-info' } do
      event :engager, transitions_to: ENGAGEE
    end

    state ENGAGEE, meta: { style: 'is-warning' } do
      event :régler, transitions_to: REGLEE
    end

    state REGLEE, meta: { style: 'is-success' } 
    state IMPAYEE, meta: { style: 'is-danger' } 
  end

  # pour que le changement se voit dans l'audit trail
  def persist_workflow_state(new_value)
    self[:workflow_state] = new_value
    save!
  end

end
