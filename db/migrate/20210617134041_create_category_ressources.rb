class CreateCategoryRessources < ActiveRecord::Migration[6.1]
  def change
    create_table :categories_ressources, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :ressource, index: true
    end
  end
end
