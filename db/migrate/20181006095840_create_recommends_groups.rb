class CreateRecommendsGroups < ActiveRecord::Migration
    def change
        create_table :recommends_groups do |t|
            t.references :recommend, :group
        end

        add_foreign_key :recommends_groups, :recommends, on_delete: :cascade, on_update: :cascade
        add_foreign_key :recommends_groups, :groups, on_delete: :cascade, on_update: :cascade
        add_index :recommends_groups, :recommend_id, unique: true
        add_index :recommends_groups, [:recommend_id, :group_id], unique: true
    end
end
