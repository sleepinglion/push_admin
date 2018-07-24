class CreateRecommends < ActiveRecord::Migration
  def change
    create_table :recommends do |t|
      t.string :title, :limit=>60, :null=>false
      t.boolean :enable, :null=>false, :default=>true
      t.integer :count, :null=>false, :default=>0
      t.timestamps :null=>false
    end
    
    create_table :recommend_contents do |t|
      t.text :content,:null=>false
    end
  end
end
