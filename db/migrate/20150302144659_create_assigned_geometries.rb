class CreateAssignedGeometries < ActiveRecord::Migration
  def change
    create_table :assigned_geometries do |t|
      t.references :simulation, index: true
      t.references :geometry, index: true

      t.timestamps null: false
    end
    add_foreign_key :assigned_geometries, :simulations
    add_foreign_key :assigned_geometries, :geometries
  end
end
