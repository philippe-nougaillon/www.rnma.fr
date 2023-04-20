class AddLiensToMaison < ActiveRecord::Migration[6.1]
  def change
    add_column :maisons, :linkedin, :string
    add_column :maisons, :youtube, :string
    add_column :maisons, :facebook, :string
    add_column :maisons, :twitter, :string
    add_column :maisons, :newsletter, :string
  end
end
