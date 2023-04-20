class ConvertLatitudeToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :maisons, :latitude, "float USING latitude::double precision"
    change_column :maisons, :longitude, "float USING latitude::double precision"
  end
end
