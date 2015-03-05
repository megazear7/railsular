class AddFinishedBooleanToGeometries < ActiveRecord::Migration
  def change
    add_column :geometries, :final, :boolean
  end
end
