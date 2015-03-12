class CreateAttributeDescriptorValues < ActiveRecord::Migration
  def change
    create_table :attribute_descriptor_values do |t|
      t.references :attribute_descriptor, index: true
      t.string :value # this is one of the allowed values for the "parent" attribute_descriptor

      t.timestamps null: false
    end
  end
end
