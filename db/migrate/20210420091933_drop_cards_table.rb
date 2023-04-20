class DropCardsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :cards
  end
end
