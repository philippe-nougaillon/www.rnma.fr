class AddNewIndexesToScopedFields < ActiveRecord::Migration[6.1]
  def change
    add_index :posts, :workflow_state
    add_index :posts, :created_at

    add_index :evenements, :workflow_state
    add_index :evenements, :membres
    add_index :evenements, :publique

    add_index :ressources, :workflow_state
    add_index :ressources, :date_publication
    add_index :ressources, :membres
  end
end
