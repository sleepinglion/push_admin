class CreateInvestmentTypes < ActiveRecord::Migration
  def change
    create_table :investment_types do |t|
      t.string :title, :limit=>60, :null=>false
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps :null=>false
    end
  end
end
