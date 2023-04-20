class AddWorkflowStateToMessage < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :workflow_state, :string
    add_index :messages, :workflow_state
  end
end
