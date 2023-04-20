class AddAdresseToMaison < ActiveRecord::Migration[6.1]
  def change
    add_column :maisons, :adresse, :string
  end
end
