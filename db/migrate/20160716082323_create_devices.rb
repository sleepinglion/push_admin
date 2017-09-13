class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user      
      t.string :device_id, :limit => 100
      t.string :registration_id, :limit => 100
      t.boolean :flag, :default => true
      t.timestamps
    end
  end
end
