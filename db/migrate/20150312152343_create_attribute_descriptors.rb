class CreateAttributeDescriptors < ActiveRecord::Migration
  def change
    create_table :attribute_descriptors do |t|
      t.references :geometry_type, index: true
      t.string :attr_type # i.e. "text-input", "select", "boolean" etc...
      t.string :display # this is that "index" thing we discussed for trying to describe how this should be displayed
      t.string :validation # if attr_type is "text-input" then this is some validation on what values this type of attribute can hold
      t.string :usage # i.e. "simulation", "geometry" or "assigned_geometry"
 
      t.timestamps null: false
    end
  end
end
