class CreateRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :régions do |t|
      t.integer :num_dep
      t.string :dep_name
      t.string :region_name

      t.timestamps
    end
  end
end
