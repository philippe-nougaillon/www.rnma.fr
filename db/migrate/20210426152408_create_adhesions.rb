class CreateAdhesions < ActiveRecord::Migration[6.1]
  def change
    create_table :adhesions do |t|
      t.references :maison, null: true, foreign_key: true
      t.string :organisme
      t.string :adresse
      t.string :cp
      t.string :ville
      t.string :nom
      t.string :prénom
      t.string :téléphone
      t.string :email
      t.string :workflow_state

      t.timestamps
    end
  end
end
