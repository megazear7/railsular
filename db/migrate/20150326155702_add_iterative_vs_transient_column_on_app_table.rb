class AddIterativeVsTransientColumnOnAppTable < ActiveRecord::Migration
  def change
    add_column :apps, :iterative, :boolean
  end
end
