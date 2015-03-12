class AttributeDescriptor < ActiveRecord::Base
  belongs_to :geometry_type
  has_many :attribute_descriptor_values
end
