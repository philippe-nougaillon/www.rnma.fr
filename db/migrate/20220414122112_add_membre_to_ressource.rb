class AddMembreToRessource < ActiveRecord::Migration[6.1]
  def change
    add_column :ressources, :membres, :boolean, default: false, null: false
    Ressource.update_all(membres: false)
  end
end
