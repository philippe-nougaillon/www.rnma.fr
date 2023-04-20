class SlideshowImage < ApplicationRecord
    audited
    has_one_attached :image
    validates :titre, :poids, :image, presence: true

    default_scope { order(:poids) }
end
