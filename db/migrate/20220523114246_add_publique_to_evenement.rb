class AddPubliqueToEvenement < ActiveRecord::Migration[6.1]
  def change
    add_column :evenements, :publique, :boolean, default: false, null: false
    Evenement.update_all(publique: false)
  end
end
