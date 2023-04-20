class CreateSlideshowImages < ActiveRecord::Migration[6.1]
  def change
    create_table :slideshow_images do |t|
      t.string :titre
      t.integer :poids, default: 0

      t.timestamps
    end
  end
end
