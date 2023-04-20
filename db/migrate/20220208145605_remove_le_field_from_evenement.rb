class RemoveLeFieldFromEvenement < ActiveRecord::Migration[6.1]
  def change
    remove_column :evenements, :le
  end
end
