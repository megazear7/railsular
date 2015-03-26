class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :simulation, index: true

      t.timestamps
    end
  end
end
