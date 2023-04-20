class ChangeContactMaisonId < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :maison_id, :integer, null: true
  end
end
