class AddWorkflowStateToCard < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :workflow_state, :string
  end
end
