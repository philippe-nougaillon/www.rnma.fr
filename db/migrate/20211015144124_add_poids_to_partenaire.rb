class AddPoidsToPartenaire < ActiveRecord::Migration[6.1]
  def change
    add_column :partenaires, :poids, :integer, default: 0
    Partenaire.update_all(poids: 0)
  end
end
