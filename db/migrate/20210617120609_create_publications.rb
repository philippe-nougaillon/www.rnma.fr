class CreatePublications < ActiveRecord::Migration[6.1]
  def change
    create_table :publications do |t|
      t.string :titre
      t.string :chapeau
      t.string :thème

      t.timestamps
    end
  end
end
