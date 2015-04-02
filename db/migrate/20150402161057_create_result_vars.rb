class CreateResultVars < ActiveRecord::Migration
  def change
    create_table :result_vars do |t|
      t.references :app, index: true
      t.string :name

      t.timestamps
    end
  end
end
