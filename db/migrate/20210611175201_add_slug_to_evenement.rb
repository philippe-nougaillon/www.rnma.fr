class AddSlugToEvenement < ActiveRecord::Migration[6.1]
  def change
    add_column :evenements, :slug, :string
    add_index :evenements, :slug
  end
end
