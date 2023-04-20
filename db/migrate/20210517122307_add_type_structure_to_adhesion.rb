class AddTypeStructureToAdhesion < ActiveRecord::Migration[6.1]
  def change
    add_column :adhesions, :type_structure, :string
  end
end
