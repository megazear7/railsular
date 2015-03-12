class AddNameFieldToAttributeDescriptor < ActiveRecord::Migration
  def change
    add_column :attribute_descriptors, :name, :string
  end
end
