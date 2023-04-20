class Category < ApplicationRecord
  audited
  default_scope -> { order(:nom) }
end
