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

ActiveRecord::Schema.define(:version => 20130519112620) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "stripe_user_id"
    t.string   "refresh_token"
    t.string   "access_token"
    t.string   "scope"
    t.string   "stripe_publishable_key"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "bloglikes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "blogupdate_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "bloglikes", ["blogupdate_id"], :name => "index_bloglikes_on_blogupdate_id"
  add_index "bloglikes", ["user_id", "blogupdate_id"], :name => "index_bloglikes_on_user_id_and_blogupdate_id", :unique => true
  add_index "bloglikes", ["user_id"], :name => "index_bloglikes_on_user_id"

  create_table "blogupdates", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "creditcards", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "stripe_token"
    t.string   "stripe_customer_id"
    t.integer  "exp_year"
    t.integer  "exp_month"
    t.string   "cvv"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "donate_affiliates", :force => true do |t|
    t.string   "name"
    t.decimal  "rate",       :precision => 10, :scale => 2
    t.string   "token"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "donate_payments", :force => true do |t|
    t.integer  "donator_id"
    t.integer  "donate_id"
    t.decimal  "amount",              :precision => 10, :scale => 2
    t.string   "transaction_id"
    t.boolean  "setup"
    t.boolean  "misc"
    t.integer  "donate_affiliate_id"
    t.decimal  "affiliate_amount",    :precision => 10, :scale => 2
    t.string   "donator_type",                                       :default => "User"
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
  end

  create_table "donate_plans", :force => true do |t|
    t.decimal  "amount",         :precision => 10, :scale => 2
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "project_title"
    t.decimal  "setup_amount",   :precision => 10, :scale => 2
    t.integer  "trial_period",                                  :default => 1
    t.string   "trial_interval",                                :default => "months"
    t.float    "unit_price"
    t.text     "description"
    t.boolean  "featured",                                      :default => false
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
  end

  create_table "donates", :force => true do |t|
    t.integer  "donator_id"
    t.string   "stripe_token"
    t.integer  "donate_plan_id"
    t.decimal  "amount",              :precision => 10, :scale => 2
    t.string   "state"
    t.string   "donator_type",                                       :default => "User"
    t.integer  "donate_affiliate_id"
    t.string   "billing_id"
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
    t.integer  "project_id"
  end

  create_table "newcomments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "newcomments", ["commentable_id", "commentable_type"], :name => "index_newcomments_on_commentable_id_and_commentable_type"
  add_index "newcomments", ["user_id", "created_at"], :name => "index_newcomments_on_user_id_and_created_at"

  create_table "project_relationships", :force => true do |t|
    t.integer  "follower_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "projectuser_id"
  end

  add_index "project_relationships", ["projectuser_id"], :name => "index_project_relationships_on_projectuser_id"

  create_table "projectcosts", :force => true do |t|
    t.text     "category"
    t.integer  "costestimate"
    t.integer  "costactual"
    t.integer  "project_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "projectlocations", :force => true do |t|
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "projecttitle"
    t.string   "projectshortdesc"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.string   "youtubelink"
    t.string   "category"
    t.integer  "project_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
    t.boolean  "submitreview",                                      :default => false
    t.boolean  "projectreviewed",                                   :default => false
    t.text     "projectletter"
    t.string   "projectimage"
    t.integer  "category_id"
    t.string   "permalink"
    t.integer  "projectlocation_id"
    t.decimal  "goal",               :precision => 10, :scale => 2
    t.integer  "funding_period",                                    :default => 60
    t.datetime "pending_started_on"
  end

  add_index "projects", ["category"], :name => "index_projects_on_category"
  add_index "projects", ["project_id"], :name => "index_projects_on_project_id"
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "redactor_assets", :force => true do |t|
    t.integer  "user_id"
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], :name => "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_redactor_assetable_type"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "review_comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "team_members", :force => true do |t|
    t.string   "membername"
    t.integer  "project_id"
    t.text     "content"
    t.string   "teamuserimage"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "ttwocomments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "newcomment_id"
    t.text     "content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.boolean  "admin",                  :default => false
    t.string   "remember_token"
    t.text     "aboutuser"
    t.string   "image"
    t.string   "balanced_account_uri"
    t.string   "permalink"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
