class AddDescriptionToRessource < ActiveRecord::Migration[6.1]
  def change
    add_column :ressources, :description, :string
  end
end
