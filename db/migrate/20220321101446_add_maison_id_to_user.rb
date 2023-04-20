class AddMaisonIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :maison_id, :integer
  end
end
