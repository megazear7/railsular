class AddAttachmentGeoToGeometries < ActiveRecord::Migration
  def self.up
    change_table :geometries do |t|
      t.attachment :geo
    end
  end

  def self.down
    remove_attachment :geometries, :geo
  end
end
