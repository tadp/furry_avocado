# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150321024327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: true do |t|
    t.integer "author_id",   null: false
    t.string  "title",       null: false
    t.text    "body"
    t.integer "vote_rating", null: false
    t.integer "view_count",  null: false
  end

  add_index "questions", ["author_id"], name: "index_questions_on_author_id", using: :btree
  add_index "questions", ["title"], name: "index_questions_on_title", using: :btree
  add_index "questions", ["view_count"], name: "index_questions_on_view_count", using: :btree
  add_index "questions", ["vote_rating"], name: "index_questions_on_vote_rating", using: :btree

  create_table "tags", force: true do |t|
    t.string "content", null: false
  end

  add_index "tags", ["content"], name: "index_tags_on_content", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string "name",            null: false
    t.string "email",           null: false
    t.string "password_digest", null: false
    t.string "session_token",   null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
