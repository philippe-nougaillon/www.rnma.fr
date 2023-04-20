class Document < ApplicationRecord
  belongs_to :adhesion
  has_one_attached :fichier
end
