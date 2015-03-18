class CreateGeometryAttrs < ActiveRecord::Migration
  def change
    create_table :geometry_attrs do |t|
      t.string :value
      t.string :name
      t.references :geometry, index: true

      t.timestamps null: false
    end
    #add_foreign_key :geometry_attrs, :geometries
  end
end
