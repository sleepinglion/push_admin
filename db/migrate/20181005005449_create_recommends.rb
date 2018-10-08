class CreateRecommends < ActiveRecord::Migration
  def change
    create_table :recommends do |t|
      t.references :admin, :null=>false
      t.references :investment_type, :null=>false, :default=>1        
      t.string :title, :limit=>60, :null=>false
      t.date :buy_date, :null=>false     
      t.integer :buy_price, :null=>false, :default=>0
      t.date :sell_date, :null=>false         
      t.integer :sell_price, :null=>false, :default=>0
      t.boolean :enable, :null=>false, :default=>true
      t.integer :count, :null=>false, :default=>0
      t.timestamps :null=>false
    end
    
    create_table :recommend_contents do |t|
      t.text :content,:null=>false
    end
  end
end
