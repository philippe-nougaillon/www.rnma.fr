class Action < ApplicationRecord
  audited

  belongs_to :contact
  belongs_to :user

  default_scope { order('id DESC') }
end