class AddTypeStructureToMaison < ActiveRecord::Migration[6.1]
  def change
    add_column :maisons, :type_structure, :string
  end
end
