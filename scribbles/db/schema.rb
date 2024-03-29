# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091126095243) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "secure_password"
    t.string   "salt"
    t.string   "email"
    t.integer  "expiration"
    t.boolean  "is_permanent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "author"
    t.text     "comment"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.integer  "account_id"
    t.string   "lock_holder"
    t.string   "secure_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_tabs", :force => true do |t|
    t.string   "name"
    t.text     "path"
    t.text     "description"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", :force => true do |t|
    t.text     "description"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
