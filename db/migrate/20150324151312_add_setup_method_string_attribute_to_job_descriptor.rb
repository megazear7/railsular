class AddSetupMethodStringAttributeToJobDescriptor < ActiveRecord::Migration
  def change
    add_column :job_descriptors, :setup_method, :string
  end
end
