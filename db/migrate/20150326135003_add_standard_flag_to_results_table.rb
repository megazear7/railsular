class AddStandardFlagToResultsTable < ActiveRecord::Migration
  def change
    add_column :results, :generic, :boolean, default: false
  end
end
