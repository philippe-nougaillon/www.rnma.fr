class AddRegionToMaison < ActiveRecord::Migration[6.1]
  def change
    add_column :maisons, :dep_name, :string
    add_column :maisons, :region_name, :string
  end
end
