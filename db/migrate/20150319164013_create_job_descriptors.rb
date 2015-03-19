class CreateJobDescriptors < ActiveRecord::Migration
  def change
    create_table :job_descriptors do |t|
      t.string :job_type
      t.integer :script_number
      t.string :test_compute_resources
      t.string :prod_compute_resources
      t.string :test_walltime
      t.string :prod_walltime

      t.timestamps
    end
  end
end
