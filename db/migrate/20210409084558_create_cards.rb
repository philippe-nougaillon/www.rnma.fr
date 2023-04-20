class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :titre
      t.string :chapeau

      t.timestamps
    end
  end
end
