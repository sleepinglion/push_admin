class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user, :null=>false
      t.string :device_id, :limit => 100, :null=>false
      t.string :registration_id, :limit => 200, :null=>false
      t.boolean :flag, :default => true, :null=>false
      t.timestamps :null=>false
    end
  end
end
