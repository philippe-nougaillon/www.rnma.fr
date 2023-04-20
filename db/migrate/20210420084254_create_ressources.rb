class CreateRessources < ActiveRecord::Migration[6.1]
  def change
    create_table :ressources do |t|
      t.string :titre
      t.string :chapeau
      t.string :slug
      t.string :workflow_state

      t.timestamps
    end
    add_index :ressources, :slug
  end
end
