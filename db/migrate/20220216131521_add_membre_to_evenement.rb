class AddMembreToEvenement < ActiveRecord::Migration[6.1]
  def change
    add_column :evenements, :membres, :boolean, default: false, null: false
    Evenement.update_all(membres: false)
  end
end
