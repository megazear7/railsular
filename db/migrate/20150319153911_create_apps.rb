class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :app_hex_code
      t.boolean :test
      t.string :app_bin
      t.string :batch_queue

      t.timestamps
    end
  end
end
