class CreateMaisonsRessources < ActiveRecord::Migration[6.1]
  def change
    create_table :maisons_ressources, id: false do |t|
      t.belongs_to :maison, index: true
      t.belongs_to :ressource, index: true
    end
  end
end
