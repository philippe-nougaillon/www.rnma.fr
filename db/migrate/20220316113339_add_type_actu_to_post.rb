class AddTypeActuToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :type_actu, :integer, default: 0, null: false
    add_index :posts, :type_actu
    Post.update_all(type_actu: 0)
  end
end
