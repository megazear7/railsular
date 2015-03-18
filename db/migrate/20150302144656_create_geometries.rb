class CreateGeometries < ActiveRecord::Migration
  def change
    create_table :geometries do |t|
      t.string :name
      t.text :description
      t.references :project, index: true

      t.timestamps null: false
    end
    #add_foreign_key :geometries, :projects
  end
end
