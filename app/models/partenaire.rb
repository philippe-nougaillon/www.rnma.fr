class Partenaire < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:nom, :description]

  audited

  has_one_attached :logo

  validates :nom, :type_partenaire, :poids, presence: true

  enum type_partenaire: { Financier: 1, Opérationnel: 2, Autre: 3 }

  scope :financier, -> { where(type_partenaire: 1) }
  scope :opérationnel, -> { where(type_partenaire: 2) }

  default_scope { order(:poids) }
end
