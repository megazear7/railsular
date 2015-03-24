class RemoveGeometryNameField < ActiveRecord::Migration
  def change
    remove_column :geometries, :name
  end
end
