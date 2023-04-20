class AddPublicationDateToRessources < ActiveRecord::Migration[6.1]
  def change
    add_column :ressources, :date_publication, :date
  end
end
