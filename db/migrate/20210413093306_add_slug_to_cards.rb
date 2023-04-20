class AddSlugToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :slug, :string
    add_index :cards, :slug, unique: true
  end
end
