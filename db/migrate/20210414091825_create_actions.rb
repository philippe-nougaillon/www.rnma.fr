class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.references :contact, null: false, foreign_key: true
      t.string :intitulé
      t.string :mémo

      t.timestamps
    end
  end
end
