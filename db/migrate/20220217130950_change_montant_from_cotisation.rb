class ChangeMontantFromCotisation < ActiveRecord::Migration[6.1]
  def change
    change_column :cotisations, :montant, :decimal, precision: 7, scale: 2, default: '0.0', null: false
  end
end
