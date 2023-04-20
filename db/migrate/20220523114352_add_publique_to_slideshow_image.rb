class AddPubliqueToSlideshowImage < ActiveRecord::Migration[6.1]
  def change
    add_column :slideshow_images, :publique, :boolean, default: false, null: false
    SlideshowImage.update_all(publique: false)
  end
end
