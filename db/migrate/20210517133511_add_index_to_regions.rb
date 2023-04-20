class AddIndexToRegions < ActiveRecord::Migration[6.1]
  def change
    add_index :régions, :num_dep
  end
end
