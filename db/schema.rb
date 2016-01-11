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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140430081012) do

  create_table "articles", :force => true do |t|
    t.string   "headline"
    t.text     "summary"
    t.text     "content"
    t.date     "date"
    t.string   "image"
    t.boolean  "display"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "pushed_to_main_site", :default => false
  end

  create_table "award_nominations", :force => true do |t|
    t.integer  "award_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "award_suggested_nomination_id"
  end

  add_index "award_nominations", ["award_id"], :name => "index_award_nominations_on_award_id"
  add_index "award_nominations", ["award_suggested_nomination_id"], :name => "index_award_nominations_on_award_suggested_nomination_id"
  add_index "award_nominations", ["user_id"], :name => "index_award_nominations_on_user_id"

  create_table "award_suggested_nominations", :force => true do |t|
    t.integer  "award_id"
    t.integer  "user_nominated_id"
    t.integer  "user_nominated_by_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.text     "reason"
    t.string   "name"
    t.string   "telephone"
    t.string   "email"
    t.string   "nomination_type"
  end

  add_index "award_suggested_nominations", ["award_id"], :name => "index_award_suggested_nominations_on_award_id"
  add_index "award_suggested_nominations", ["user_nominated_by_id"], :name => "index_award_suggested_nominations_on_user_nominated_by_id"
  add_index "award_suggested_nominations", ["user_nominated_id"], :name => "index_award_suggested_nominations_on_user_nominated_id"

  create_table "award_votes", :force => true do |t|
    t.integer  "award_id"
    t.integer  "nomination_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "award_votes", ["award_id"], :name => "index_award_votes_on_award_id"
  add_index "award_votes", ["nomination_id"], :name => "index_award_votes_on_nomination_id"
  add_index "award_votes", ["user_id"], :name => "index_award_votes_on_user_id"

  create_table "awards", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.text     "description"
    t.string   "mode"
    t.boolean  "display"
    t.integer  "position"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "award_nominations_count",           :default => 0
    t.integer  "award_suggested_nominations_count", :default => 0
    t.integer  "award_votes_count",                 :default => 0
    t.integer  "award_suggested_nomination_id"
  end

  add_index "awards", ["award_suggested_nomination_id"], :name => "index_awards_on_award_suggested_nomination_id"

  create_table "chronicler_documents", :force => true do |t|
    t.string   "name"
    t.string   "document"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chronicler_images", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "email_items", :force => true do |t|
    t.integer  "email_id"
    t.string   "email_item_type"
    t.integer  "email_item_id"
    t.integer  "position",        :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "email_items", ["email_id"], :name => "index_email_items_on_email_id"

  create_table "emails", :force => true do |t|
    t.string   "template"
    t.string   "subject"
    t.text     "heading"
    t.text     "summary"
    t.text     "content"
    t.string   "image"
    t.string   "image_alt"
    t.string   "campaign_id"
    t.boolean  "campaign_sent", :default => false
    t.string   "list_id"
    t.string   "list_name"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.text     "summary"
    t.text     "content"
    t.string   "image"
    t.boolean  "display"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "footer_links", :force => true do |t|
    t.integer  "position"
    t.string   "title"
    t.string   "link"
    t.boolean  "display"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "manticore_administrators", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "role"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_send_at"
  end

  create_table "members", :force => true do |t|
    t.integer  "position"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.string   "image"
    t.text     "biography"
    t.boolean  "display"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group"
  end

  create_table "pages", :force => true do |t|
    t.string   "layout"
    t.string   "style"
    t.string   "title"
    t.string   "image"
    t.text     "content"
    t.string   "slug"
    t.boolean  "display",    :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "pages", ["slug"], :name => "index_pages_on_slug", :unique => true

  create_table "sale_categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "shoutboxes_count", :default => 0
  end

  create_table "shoutboxes", :force => true do |t|
    t.string   "title"
    t.text     "message"
    t.integer  "shout_id"
    t.integer  "user_id"
    t.boolean  "reported"
    t.boolean  "display"
    t.datetime "created"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "ancestry"
    t.integer  "ancestry_depth"
    t.datetime "edited_at"
    t.string   "image"
    t.boolean  "sale_item"
    t.integer  "sale_category_id"
    t.boolean  "item_sold"
    t.boolean  "rumour"
  end

  add_index "shoutboxes", ["ancestry"], :name => "index_shoutboxes_on_ancestry"
  add_index "shoutboxes", ["sale_category_id"], :name => "index_shoutboxes_on_sale_category_id"
  add_index "shoutboxes", ["shout_id"], :name => "index_shoutboxes_on_shout_id"
  add_index "shoutboxes", ["user_id"], :name => "index_shoutboxes_on_user_id"

  create_table "sliders", :force => true do |t|
    t.text     "headline"
    t.string   "image"
    t.string   "link"
    t.boolean  "display"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "staff_benefits", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.boolean  "display"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
    t.text     "details"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "job_title"
    t.string   "department"
    t.text     "profile"
    t.string   "phone_number"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "photo"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "active_user"
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "postcode"
    t.string   "image"
    t.boolean  "display"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "willow_branches", :force => true do |t|
    t.string  "tree"
    t.string  "name"
    t.integer "position",              :default => 0
    t.string  "ancestry"
    t.integer "ancestry_depth",        :default => 0
    t.string  "positions_depth_cache"
    t.integer "leaf_id"
    t.string  "leaf_type"
    t.boolean "sturdy",                :default => false
    t.boolean "can_have_children",     :default => false
    t.boolean "primary",               :default => false
    t.string  "access_key"
  end

  add_index "willow_branches", ["ancestry"], :name => "index_willow_branches_on_ancestry"

  create_table "willow_leaves", :force => true do |t|
    t.string "name"
    t.string "route"
    t.string "type"
  end

end
