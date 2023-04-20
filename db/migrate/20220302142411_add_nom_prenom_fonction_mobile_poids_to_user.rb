class AddNomPrenomFonctionMobilePoidsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nom, :string
    add_column :users, :prénom, :string
    add_column :users, :fonction, :string
    add_column :users, :mobile, :string
    add_column :users, :poids, :integer, default: 0
  end
end
