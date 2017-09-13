class AddUsersDevise < ActiveRecord::Migration
    def change
        add_column :users, :group_id, :integer, default: 1, null: false, after: 'id'
        add_column :users, :login_id, :string, limit: 100, after: 'group_id'
        add_column :users, :encrypted_password, :string, limit: 60
        add_column :users, :reset_password_token, :string, limit: 150
        add_column :users, :reset_password_sent_at, :datetime
        add_column :users, :sign_in_count, :integer, default: 0
        add_column :users, :current_sign_in_at, :datetime
        add_column :users, :last_sign_in_at, :datetime
        add_column :users, :current_sign_in_ip, :string, limit: 100
        add_column :users, :last_sign_in_ip, :string, limit: 100
        add_column :users, :device_count, :integer, default: 1, null: false

        add_foreign_key :users, :groups, on_delete: :cascade, on_update: :cascade
        add_index :users, :login_id, unique: true
    end
end
