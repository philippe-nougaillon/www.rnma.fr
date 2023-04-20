class CreatePartenaires < ActiveRecord::Migration[6.1]
  def change
    create_table :partenaires do |t|
      t.string :nom
      t.integer :type_partenaire, null: false
      t.string :lien

      t.timestamps
    end
  end
end
