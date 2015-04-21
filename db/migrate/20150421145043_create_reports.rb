class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :message
      t.references :reportable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
