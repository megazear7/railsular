class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :status
      t.string :pbsid
      t.string :job_path
      t.string :script_name
      t.references :simulation, index: true
      t.references :geometry, index: true

      t.timestamps null: false
    end
    #add_foreign_key :jobs, :simulations
    #add_foreign_key :jobs, :geometries
  end
end
