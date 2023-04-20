class Maison < ApplicationRecord
    include RegionsConcern

    extend FriendlyId
    friendly_id :nom, use: :slugged

    include PgSearch::Model
    multisearchable against: [:nom, :ville, :region_name],
                    if: :searchable?

    audited

    has_one :adhesion

    has_many :contacts, dependent: :destroy
    has_many :actions, through: :contacts
    has_many :cotisations, through: :adhesion
    has_many :users

    accepts_nested_attributes_for :contacts, 
                                    allow_destroy: true, 
                                    reject_if: lambda { |attributes| attributes['nom'].blank? }

    has_rich_text :corps
    has_one :action_text_rich_text,
            class_name: 'ActionText::RichText',
            as: :record

    has_one_attached :logo

    default_scope { joins(:adhesion).where("adhesions.workflow_state != 'archivée'").order('maisons.id DESC') }

    def searchable?
        self.try(:adhesion).try(:validée?)
    end

    # Pas déplaçable dans le décorator, ville_mda est appelé dans un option_select
    def ville_mda
        self.ville + ' | ' + self.nom
    end
    
end
