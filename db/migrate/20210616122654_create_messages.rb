class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :nom
      t.string :structure
      t.string :email
      t.string :téléphone
      t.text :message

      t.timestamps
    end
  end
end
