class AddGeoTypeToGeometry < ActiveRecord::Migration
  def change
    add_column :geometries, :geo_type, :string
  end
end
