class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :name, null: false, limit: 40
            t.date :birthday
            t.string :phone, limit: 40, null: true
            t.boolean :sex, :boolean, null: true, default: nil
            t.boolean :enable, null: false, default: false
            t.string :photo, limit: 100
            t.timestamps
        end
    end
end
