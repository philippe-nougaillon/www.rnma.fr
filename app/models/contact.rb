class Contact < ApplicationRecord
  include RegionsConcern

  extend FriendlyId
  friendly_id :nom_prénom, use: :slugged

  audited
  
  belongs_to :maison, optional: true

  has_many :actions, dependent: :destroy

  accepts_nested_attributes_for :actions, 
                                allow_destroy: true, 
                                reject_if: lambda {|attributes| attributes['intitulé'].blank? }

  validates :email, uniqueness: true

  has_rich_text :mémo

  acts_as_taggable_on :tags

  default_scope { order('id DESC') }

  scope :abonné, -> { where(abonne: true) }

  after_create :tag_new_contact_as_member

  def maison_organisation
    self.maison_id ? Maison.unscoped.find(self.maison_id).nom : self.organisation
  end

  # Pas déplaçable dans le décorator, nom_prénom est appelé dans friendly_id
  def nom_prénom
    "#{ self.nom } #{ self.prénom }"
  end

  # Pas déplaçable dans le décorator, nom_prénom_organisation est appelé dans un option_select
  def nom_prénom_organisation
    self.nom + ' ' + self.prénom + ' / ' + self.maison_organisation
  end

  private

  def tag_new_contact_as_member
    self.tag_list.add("Membre") if self.maison
  end


end
