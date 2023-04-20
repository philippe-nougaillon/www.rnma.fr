class AddMembreToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :membre, :boolean, default: false, null: false
    Post.update_all(membre: false)
  end
end
