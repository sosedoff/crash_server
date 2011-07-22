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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110722211554) do

  create_table "apps", :force => true do |t|
    t.string   "name",       :limit => 64,                   :null => false
    t.string   "api_key",    :limit => 64,                   :null => false
    t.boolean  "enabled",                  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apps", ["api_key"], :name => "index_apps_on_api_key"
  add_index "apps", ["name"], :name => "index_apps_on_name"

  create_table "crashes", :force => true do |t|
    t.integer  "app_id",                                              :null => false
    t.string   "uuid",             :limit => 64,                      :null => false
    t.string   "status",           :limit => 16,  :default => "open"
    t.string   "class_name",       :limit => 128,                     :null => false
    t.string   "message"
    t.text     "backtrace"
    t.text     "environment"
    t.string   "framework",        :limit => 16
    t.datetime "created_at"
    t.datetime "last_occurred_at"
    t.integer  "occurrences",                     :default => 1
  end

  add_index "crashes", ["uuid"], :name => "index_crashes_on_uuid"

  create_table "deployments", :force => true do |t|
    t.integer  "app_id",                            :null => false
    t.string   "action",             :limit => 32
    t.string   "message"
    t.string   "capistrano_version", :limit => 16
    t.string   "payload_version",    :limit => 16
    t.string   "deployer_user",      :limit => 64
    t.string   "deployer_hostname",  :limit => 128
    t.string   "source_branch",      :limit => 64
    t.string   "source_revision",    :limit => 64
    t.string   "source_repository"
    t.datetime "created_at"
  end

  add_index "deployments", ["app_id", "action"], :name => "index_deployments_on_app_id_and_action"
  add_index "deployments", ["app_id"], :name => "index_deployments_on_app_id"

end
