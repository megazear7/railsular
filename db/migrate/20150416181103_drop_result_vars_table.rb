class DropResultVarsTable < ActiveRecord::Migration
  def change
    drop_table :result_vars
  end
end
