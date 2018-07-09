class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user, :null=>false
      t.string :os  , :limit=>50, :null=>false
      t.string :registration_id, :limit => 200, :null=>false
      t.boolean :enable, :default => true, :null=>false
      t.timestamps :null=>false
    end
  end
end
