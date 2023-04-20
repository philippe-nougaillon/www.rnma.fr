class AddSlugToPublication < ActiveRecord::Migration[6.1]
  def change
    add_column :publications, :slug, :string
    add_index :publications, :slug
  end
end
