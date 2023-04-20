class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :titre
      t.string :chapeau
      t.string :workflow_state

      t.timestamps
    end
  end
end
