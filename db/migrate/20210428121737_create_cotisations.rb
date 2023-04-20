class CreateCotisations < ActiveRecord::Migration[6.1]
  def change
    create_table :cotisations do |t|
      t.references :adhesion, null: false, foreign_key: true
      t.string :période, null: false
      t.decimal :montant, precision: 5, scale: 2, default: '0.0', null: false
      t.date :date_échéance
      t.string :workflow_state
      t.string :mémo

      t.timestamps
    end
  end
end
