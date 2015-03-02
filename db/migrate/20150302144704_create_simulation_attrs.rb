class CreateSimulationAttrs < ActiveRecord::Migration
  def change
    create_table :simulation_attrs do |t|
      t.string :value
      t.string :name
      t.references :simulation, index: true

      t.timestamps null: false
    end
    add_foreign_key :simulation_attrs, :simulations
  end
end
