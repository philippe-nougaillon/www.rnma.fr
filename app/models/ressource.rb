class Ressource < ApplicationRecord

    include Workflow
    include WorkflowActiverecord
    
    extend FriendlyId
    friendly_id :titre, use: :slugged
    
    include PgSearch::Model
    multisearchable against: [:titre, :chapeau, :description],
                    if: :searchable?

    audited
    
    has_one_attached :photo
    has_rich_text :corps
    has_one :action_text_rich_text,
            class_name: 'ActionText::RichText',
            as: :record

    has_many_attached :documents 

    has_and_belongs_to_many :maisons
    accepts_nested_attributes_for :maisons, 
                                    allow_destroy: true, 
                                    reject_if: lambda { |attributes| attributes['id'].blank? }

    has_and_belongs_to_many :categories
    accepts_nested_attributes_for :categories, 
                                    allow_destroy: true, 
                                    reject_if: lambda { |attributes| attributes['id'].blank? }
                                
    has_and_belongs_to_many :typologies
    accepts_nested_attributes_for :typologies, 
                                    allow_destroy: true, 
                                    reject_if: lambda { |attributes| attributes['id'].blank? }
                                

    acts_as_taggable_on :tags

    validates_presence_of :titre

    default_scope { order('id DESC') }

    paginates_per 20

    # WORKFLOW
    BROUILLON    = 'brouillon'
    VALIDEE      = 'validée'
    PUBLIEE      = 'publiée'
    PARTAGEE     = 'partagée'
    PROMUE       = 'promue'
    ARCHIVEE     = 'archivée'

    scope :publiée, -> { where(workflow_state: [PUBLIEE, PROMUE]) }
    scope :promue, -> { where(workflow_state: PROMUE) }
    scope :fraiche, -> { where(date_publication: 22.days.ago..Date.tomorrow) }

    workflow do
        state BROUILLON, meta: { style: 'is-info' } do
            event :valider, transitions_to: VALIDEE
        end

        state VALIDEE, meta: { style: 'is-success' } do
            event :publier, transitions_to: PUBLIEE
        end

        state PUBLIEE, meta: { style: 'is-danger' } do
            event :partager, transitions_to: PARTAGEE
            event :promouvoir, transitions_to: PROMUE
            event :archiver, transitions_to: ARCHIVEE
        end

        state PARTAGEE, meta: { style: 'is-link' } do
            event :promouvoir, transitions_to: PROMUE
            event :archiver, transitions_to: ARCHIVEE
        end

        state PROMUE, meta: { style: 'is-warning' } do
            event :archiver, transitions_to: ARCHIVEE
        end

        state ARCHIVEE, meta: { style: 'is-secondary' }
    end

    # pour que le changement se voit dans l'audit trail
    def persist_workflow_state(new_value)
        self[:workflow_state] = new_value
        save!
    end

    def searchable?
        self.workflow_state >= PUBLIEE
    end

end
