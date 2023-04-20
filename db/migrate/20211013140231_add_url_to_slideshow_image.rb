class AddUrlToSlideshowImage < ActiveRecord::Migration[6.1]
  def change
    add_column :slideshow_images, :url, :string
  end
end
