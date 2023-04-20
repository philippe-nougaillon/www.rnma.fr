class AddNatureToAdhesion < ActiveRecord::Migration[6.1]
  def change
    add_column :adhesions, :nature, :string
  end
end
