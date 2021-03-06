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

ActiveRecord::Schema.define(version: 20150402204735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer "commentable_id"
    t.string  "commentable_type"
    t.integer "commenter_id",     null: false
    t.text    "body",             null: false
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commenter_id"], name: "index_comments_on_commenter_id", using: :btree

  create_table "questions", force: true do |t|
    t.integer "author_id", null: false
    t.string  "title",     null: false
    t.text    "body"
  end

  add_index "questions", ["author_id"], name: "index_questions_on_author_id", using: :btree
  add_index "questions", ["title"], name: "index_questions_on_title", using: :btree

  create_table "responses", force: true do |t|
    t.integer "author_id",                   null: false
    t.integer "question_id",                 null: false
    t.text    "body"
    t.boolean "accepted",    default: false, null: false
  end

  add_index "responses", ["accepted"], name: "index_responses_on_accepted", using: :btree
  add_index "responses", ["author_id"], name: "index_responses_on_author_id", using: :btree
  add_index "responses", ["question_id"], name: "index_responses_on_question_id", using: :btree

  create_table "tag_assignments", force: true do |t|
    t.integer "taggable_id"
    t.string  "taggable_type"
    t.integer "tag_id",        null: false
  end

  add_index "tag_assignments", ["tag_id"], name: "index_tag_assignments_on_tag_id", using: :btree
  add_index "tag_assignments", ["taggable_id", "taggable_type", "tag_id"], name: "tag_assignments_on_taggable_id_and_taggable_type_and_tag_id", unique: true, using: :btree
  add_index "tag_assignments", ["taggable_id"], name: "index_tag_assignments_on_taggable_id", using: :btree

  create_table "tags", force: true do |t|
    t.string "name", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string "name",            null: false
    t.string "username",        null: false
    t.string "email",           null: false
    t.string "password_digest", null: false
    t.string "session_token",   null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer "voteable_id"
    t.string  "voteable_type"
    t.integer "voter_id",      null: false
    t.boolean "upvoted",       null: false
  end

  add_index "votes", ["voteable_id", "voteable_type", "voter_id"], name: "index_votes_on_voteable_id_and_voteable_type_and_voter_id", unique: true, using: :btree
  add_index "votes", ["voteable_id"], name: "index_votes_on_voteable_id", using: :btree
  add_index "votes", ["voter_id"], name: "index_votes_on_voter_id", using: :btree

end
