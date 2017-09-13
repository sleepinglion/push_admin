class CreatePushPreparePictures < ActiveRecord::Migration
    def change
        create_table :push_prepare_pictures do |t|
            t.string :photo, limit: 100
            t.boolean :enable, null: false, default: true
            t.timestamps
        end
    end
end
