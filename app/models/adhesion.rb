class Adhesion < ApplicationRecord
  include Workflow
  include WorkflowActiverecord

  audited

  belongs_to :maison, optional: true

  has_one_attached :doc_1
  has_one_attached :doc_2
  has_one_attached :doc_3
  has_one_attached :doc_4
  has_one_attached :doc_5
  has_one_attached :doc_6 

  has_many :documents

  accepts_nested_attributes_for :documents, 
                                allow_destroy: true

  has_many :cotisations

  validates :email, presence: true, 'valid_email_2/email': true

  default_scope { order('id DESC') }

  # WORKFLOW
  NOUVELLE  = 'nouvelle'
  COMPLET   = 'complet'
  VALIDEE   = 'validée'
  RESILIEE  = 'résiliée'
  ARCHIVEE  = 'archivée'

  workflow do
    state NOUVELLE, meta: { style: 'is-info' } do
      event :complet, transitions_to: COMPLET
    end

    state COMPLET, meta: { style: 'is-warning' } do
      event :valider, transitions_to: VALIDEE
    end

    state VALIDEE, meta: { style: 'is-success' } do
      event :résilier, transitions_to: RESILIEE
    end

    state RESILIEE, meta: { style: 'is-danger' } do
      event :archiver, transitions_to: ARCHIVEE
    end

    state ARCHIVEE, meta: { style: 'is-secondary' } do
      event :renouveler, transitions_to: VALIDEE
    end
  end

  # pour que le changement se voit dans l'audit trail
  def persist_workflow_state(new_value)
    self[:workflow_state] = new_value
    save!
  end

end
