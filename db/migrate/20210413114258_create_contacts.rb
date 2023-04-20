class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.references :maison, null: false, foreign_key: true
      t.string :nom
      t.string :prénom
      t.string :fonction
      t.string :téléphone
      t.string :email

      t.timestamps
    end
  end
end
