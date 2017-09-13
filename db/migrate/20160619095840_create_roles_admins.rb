class CreateRolesAdmins < ActiveRecord::Migration
    def change
        create_table :roles_admins do |t|
            t.references :role, :admin
        end

        add_foreign_key :roles_admins, :roles, on_delete: :cascade, on_update: :cascade
        add_foreign_key :roles_admins, :admins, on_delete: :cascade, on_update: :cascade
        add_index :roles_admins, :admin_id, unique: true
        add_index :roles_admins, [:role_id, :admin_id], unique: true
    end
end
