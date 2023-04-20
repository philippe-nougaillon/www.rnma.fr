class CreateMaisons < ActiveRecord::Migration[6.1]
  def change
    create_table :maisons do |t|
      t.string :nom
      t.string :cp
      t.string :ville
      t.string :téléphone
      t.string :email
      t.string :latitude
      t.string :longitude
      t.text   :description

      t.timestamps
    end
  end
end
