class AddFonctionToAdhesion < ActiveRecord::Migration[6.1]
  def change
    add_column :adhesions, :fonction, :string
  end
end
