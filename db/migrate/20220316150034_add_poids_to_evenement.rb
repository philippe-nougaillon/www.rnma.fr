class AddPoidsToEvenement < ActiveRecord::Migration[6.1]
  def change
    add_column :evenements, :poids, :integer, default: 0
    Evenement.update_all(poids: 0)
  end
end
