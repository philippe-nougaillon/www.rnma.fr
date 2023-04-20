class AddWorkflowStateToPublication < ActiveRecord::Migration[6.1]
  def change
    add_column :publications, :workflow_state, :string
    add_index :publications, :workflow_state
  end
end
