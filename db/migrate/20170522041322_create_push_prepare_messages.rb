class CreatePushPrepareMessages < ActiveRecord::Migration
    def change
        create_table :push_prepare_messages do |t|
            t.string :title, limit: 60
            t.text :content
            t.boolean :enable, null: false, default: true
            t.timestamps
        end
    end
end
