class Typology < ApplicationRecord
  audited
  default_scope -> { order(:nom) }
end
