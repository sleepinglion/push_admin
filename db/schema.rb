# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170902082745) do

  create_table "admins", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "login_id",           limit: 60,                 null: false
    t.string   "email",              limit: 100
    t.string   "nickname",           limit: 100
    t.string   "encrypted_password", limit: 60,                 null: false
    t.string   "photo",              limit: 150
    t.boolean  "enable",                         default: true, null: false
    t.integer  "sign_in_count",                  default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["login_id"], name: "index_admins_on_login_id", unique: true
    t.index ["nickname"], name: "index_admins_on_nickname", unique: true
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
  end

  create_table "devices", force: :cascade do |t|
    t.string   "device_id",       limit: 100
    t.string   "registration_id", limit: 100
    t.integer  "user_id"
    t.boolean  "flag",                        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "title",       limit: 60
    t.integer  "users_count",            default: 0,    null: false
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "push_prepare_messages", force: :cascade do |t|
    t.string   "title",      limit: 60
    t.text     "content"
    t.boolean  "enable",                default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "push_prepare_pictures", force: :cascade do |t|
    t.string   "photo",      limit: 100
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "title",      limit: 60,                null: false
    t.boolean  "enable",                default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_admins", force: :cascade do |t|
    t.integer "role_id"
    t.integer "admin_id"
    t.index ["admin_id"], name: "index_roles_admins_on_admin_id", unique: true
    t.index ["role_id", "admin_id"], name: "index_roles_admins_on_role_id_and_admin_id", unique: true
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "app_id"
    t.index ["device_token"], name: "index_rpush_feedback_on_device_token"
  end

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.text     "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
    t.boolean  "content_available",            default: false
    t.text     "notification"
    t.index ["app_id", "delivered", "failed", "deliver_after"], name: "index_rapns_notifications_multi"
    t.index ["delivered", "failed"], name: "index_rpush_notifications_multi"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 40,                  null: false
    t.date     "birthday"
    t.string   "phone",                  limit: 40
    t.boolean  "sex"
    t.boolean  "boolean"
    t.boolean  "enable",                             default: false, null: false
    t.string   "photo",                  limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id",                           default: 1,     null: false
    t.string   "login_id",               limit: 100
    t.string   "encrypted_password",     limit: 60
    t.string   "reset_password_token",   limit: 150
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 100
    t.string   "last_sign_in_ip",        limit: 100
    t.integer  "device_count",                       default: 1,     null: false
    t.index ["login_id"], name: "index_users_on_login_id", unique: true
  end

end
