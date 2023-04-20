class CreateSibs < ActiveRecord::Migration[6.1]
  def change
    create_table :sibs do |t|
      t.string :intitulé
      t.date :envoyée_le
      t.string :url

      t.timestamps
    end
  end
end
