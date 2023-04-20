class Evenement < ApplicationRecord
  include Sortable::Model
  include Workflow
  include WorkflowActiverecord

  extend FriendlyId
  friendly_id :titre, use: :slugged

  include PgSearch::Model
  multisearchable against: [:titre, :lieu],
                  if: :searchable?

  audited

  has_one_attached :photo
  has_rich_text :contenu

  default_scope -> { order(updated_at: :desc) }

  paginates_per 20

  sortable :debut

  # WORKFLOW
  NOUVEAU  = 'nouveau'
  PUBLIE   = 'publié'
  ARCHIVE  = 'archivé'
  PROMU    = 'promu'
  
  workflow do
    state NOUVEAU, meta: { style: 'is-info' } do
      event :publier, transitions_to: PUBLIE
    end

    state PUBLIE, meta: { style: 'is-success' } do
      event :promouvoir, transitions_to: PROMU
      event :archiver, transitions_to: ARCHIVE
    end

    state PROMU, meta: { style: 'is-warning' } do
      event :archiver, transitions_to: ARCHIVE
    end

    state ARCHIVE, meta: { style: 'is-secondary' } do 
      event :publier, transitions_to: PUBLIE
    end
  end

  scope :publié, -> { where(workflow_state: [PUBLIE, PROMU] )}
  scope :promu, -> { where(workflow_state: PROMU )}
  scope :futur, -> { where("debut >= ?", DateTime.now).reorder(:debut) }

  # pour que le changement se voit dans l'audit trail
  def persist_workflow_state(new_value)
    self[:workflow_state] = new_value
    save!
  end

  def searchable?
    (self.workflow_state >= PUBLIE) && !(self.membres)
  end

end
