class AddInstagramFieldToMaison < ActiveRecord::Migration[6.1]
  def change
    add_column :maisons, :instagram, :string
  end
end
