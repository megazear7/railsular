class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.boolean :generic, default: false
      t.string :x_var
      t.string :y_var
      t.string :result_type

      t.timestamps
    end

    create_table :results_simulations do |t|
      t.integer :result_id
      t.integer :simulation_id
    end
  end
end
