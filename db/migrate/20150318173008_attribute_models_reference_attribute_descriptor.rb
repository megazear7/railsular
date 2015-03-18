class AttributeModelsReferenceAttributeDescriptor < ActiveRecord::Migration
  def change
    add_column :assigned_geo_attrs, :attribute_descriptor_id, :integer
    remove_column :assigned_geo_attrs, :name

    add_column :geometry_attrs, :attribute_descriptor_id, :integer
    remove_column :geometry_attrs, :name

    add_column :simulation_attrs, :attribute_descriptor_id, :integer
    remove_column :simulation_attrs, :name

    remove_column :geometries, :geo_type
  end
end
