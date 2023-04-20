class CreateProjets < ActiveRecord::Migration[6.1]
  def change
    create_table :projets do |t|
      t.string :titre
      t.string :chapeau
      t.string :thème
      t.string :workflow_state
      t.string :slug

      t.timestamps
    end
  end
end
