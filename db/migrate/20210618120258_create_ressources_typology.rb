class CreateRessourcesTypology < ActiveRecord::Migration[6.1]
  def change
    create_table :ressources_typologies, id: false do |t|
      t.belongs_to :typology, index: true
      t.belongs_to :ressource, index: true
      t.timestamps
    end
  end
end
