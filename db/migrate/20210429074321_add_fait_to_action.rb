class AddFaitToAction < ActiveRecord::Migration[6.1]
  def change
    add_column :actions, :fait, :boolean
    add_column :actions, :date_rappel, :datetime
  end
end
