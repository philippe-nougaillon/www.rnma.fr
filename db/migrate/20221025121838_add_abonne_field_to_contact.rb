class AddAbonneFieldToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :abonne, :boolean, null: false, default: false
    add_index :contacts, :abonne

    Contact.update_all(abonne: false)
  end
end
