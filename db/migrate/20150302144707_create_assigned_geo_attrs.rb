class CreateAssignedGeoAttrs < ActiveRecord::Migration
  def change
    create_table :assigned_geo_attrs do |t|
      t.string :value
      t.string :name
      t.references :assigned_geometry, index: true

      t.timestamps null: false
    end
    add_foreign_key :assigned_geo_attrs, :assigned_geometries
  end
end
