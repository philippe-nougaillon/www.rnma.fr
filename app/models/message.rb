class Message < ApplicationRecord
  audited
  include Workflow
  include WorkflowActiverecord

  validates :email, presence: true, 'valid_email_2/email': true

  default_scope -> { order(updated_at: :desc) }

  scope :nouveau, -> { where(workflow_state: NOUVEAU )}

  acts_as_taggable_on :tags

  paginates_per 20


  # WORKFLOW
  NOUVEAU   = 'nouveau'
  TRAITE    = 'traité'
  ARCHIVE   = 'archivé'

  workflow do
    state NOUVEAU, meta: { style: 'warning' } do
      event :traiter, transitions_to: TRAITE
    end

    state TRAITE, meta: { style: 'success' } do
      event :archiver, transitions_to: ARCHIVE
    end

    state ARCHIVE, meta: { style: 'light' }

  end

  # pour que le changement se voit dans l'audit trail
  def persist_workflow_state(new_value)
    self[:workflow_state] = new_value
    save!
  end
end
