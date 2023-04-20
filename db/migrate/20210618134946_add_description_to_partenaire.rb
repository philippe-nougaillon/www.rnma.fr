class AddDescriptionToPartenaire < ActiveRecord::Migration[6.1]
  def change
    add_column :partenaires, :description, :text
  end
end
