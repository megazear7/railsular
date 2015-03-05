class AddFinalBooleanToSimulations < ActiveRecord::Migration
  def change
    add_column :simulations, :final, :boolean
  end
end
