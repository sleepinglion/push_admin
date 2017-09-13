class CreateGroups < ActiveRecord::Migration
    def change
        create_table :groups do |t|
            t.string :title, limit: 60
            t.integer :users_count, null: false, default: false
            t.boolean :enable, null: false, default: true
            t.timestamps null: false
        end
    end
end
