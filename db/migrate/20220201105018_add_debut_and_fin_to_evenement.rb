class AddDebutAndFinToEvenement < ActiveRecord::Migration[6.1]
  def change
    add_column :evenements, :debut, :datetime
    add_column :evenements, :fin, :datetime
  end
end
