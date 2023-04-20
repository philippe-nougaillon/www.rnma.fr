class AddWorkflowStateToEvenement < ActiveRecord::Migration[6.1]
  def change
    add_column :evenements, :workflow_state, :string
  end
end
