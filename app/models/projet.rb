class Projet < ApplicationRecord
    include Workflow
    include WorkflowActiverecord
    
    extend FriendlyId
    friendly_id :titre, use: :slugged
  
    include PgSearch::Model
    multisearchable against: [:titre, :chapeau], if: :searchable?
  
    audited
    
    has_one_attached :photo
    has_one_attached :document
    has_rich_text :contenu
  
    paginates_per 20

    default_scope { order(:poids)}
  
    # WORKFLOW
    NOUVEAU  = 'nouveau'
    PUBLIE   = 'publié'
    ARCHIVE  = 'archivé'
  
    scope :publié, -> { where(workflow_state: PUBLIE) }
  
    workflow do
      state NOUVEAU, meta: { style: 'is-info' } do
        event :publier, transitions_to: PUBLIE
      end
  
      state PUBLIE, meta: { style: 'is-success' } do
        event :archiver, transitions_to: ARCHIVE
      end
  
      state ARCHIVE, meta: { style: 'is-secondary' } do 
        event :publier, transitions_to: PUBLIE
      end
    end
  
    # pour que le changement se voit dans l'audit trail
    def persist_workflow_state(new_value)
      self[:workflow_state] = new_value
      save!
    end

    def searchable?
      self.publié?
    end
end
