class AddPoidsToProjet < ActiveRecord::Migration[6.1]
  def change
    add_column :projets, :poids, :integer, null: false, default: 0
    Projet.update_all(poids: 0)
  end
end
