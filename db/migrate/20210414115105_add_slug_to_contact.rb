class AddSlugToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :slug, :string
  end
end
