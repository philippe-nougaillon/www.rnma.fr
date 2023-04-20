class AddAdresseToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :adresse, :string
    add_column :contacts, :cp, :string
    add_column :contacts, :ville, :string
    add_column :contacts, :dep_name, :string
    add_column :contacts, :region_name, :string
  end
end
