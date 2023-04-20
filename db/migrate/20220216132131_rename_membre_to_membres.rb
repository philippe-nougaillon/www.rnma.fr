class RenameMembreToMembres < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :membre, :membres
  end
end
