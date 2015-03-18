class CreateSimulations < ActiveRecord::Migration
  def change
    create_table :simulations do |t|
      t.string :name
      t.text :description
      t.references :project, index: true

      t.timestamps null: false
    end
    #add_foreign_key :simulations, :projects
  end
end
