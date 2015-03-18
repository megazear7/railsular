class AddGeometryTypeForeignKeyToGeometry < ActiveRecord::Migration
  def change
    add_column :geometries, :geometry_type_id, :integer
  end
end
