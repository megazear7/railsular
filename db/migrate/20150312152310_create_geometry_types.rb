class CreateGeometryTypes < ActiveRecord::Migration
  def change
    create_table :geometry_types do |t|
      t.string :name # i.e. "inlet", "outlet", "wall", "fan" etc...

      t.timestamps null: false
    end
  end
end
