class AddSiteToMaison < ActiveRecord::Migration[6.1]
  def change
    add_column :maisons, :site, :string
  end
end
