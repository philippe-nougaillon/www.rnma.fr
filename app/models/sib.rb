class Sib < ApplicationRecord
  audited

  default_scope {order(envoyée_le: :desc)}
end
