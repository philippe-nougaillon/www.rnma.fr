class AddMembreToSlideshowImage < ActiveRecord::Migration[6.1]
  def change
    add_column :slideshow_images, :membres, :boolean, default: false, null: false
    SlideshowImage.update_all(membres: false)
  end
end
