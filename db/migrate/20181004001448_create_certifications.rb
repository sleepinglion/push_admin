class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.references :user, :null=>false      
      t.string :title, :limit=>60, :null=>false
      t.integer :buy_price, :null=>false, :default=>0      
      t.integer :sell_price, :null=>false, :default=>0
      t.boolean :enable, :null=>false, :default=>true
      t.integer :count, :null=>false, :default=>0
      t.timestamps :null=>false
    end
    
    create_table :certification_contents do |t|
      t.text :content,:null=>false
    end
  end
end
