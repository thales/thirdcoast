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

ActiveRecord::Schema.define(:version => 20120618100005) do

  create_table "airings", :force => true do |t|
    t.date     "date"
    t.integer  "feature_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "airings", ["date"], :name => "index_airings_on_date"

  create_table "assets", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 25
    t.string   "type",              :limit => 25
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["assetable_id", "assetable_type", "type"], :name => "ndx_type_assetable"
  add_index "assets", ["assetable_id", "assetable_type"], :name => "fk_assets"
  add_index "assets", ["user_id"], :name => "fk_user"

  create_table "audio_files", :force => true do |t|
    t.integer  "length"
    t.string   "mp3_file_name"
    t.string   "mp3_content_type"
    t.integer  "mp3_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feature_id"
    t.integer  "duration"
    t.boolean  "downloadable"
    t.integer  "played",           :default => 0
  end

  add_index "audio_files", ["duration"], :name => "index_audio_files_on_duration"
  add_index "audio_files", ["feature_id"], :name => "index_audio_files_on_feature_id"
  add_index "audio_files", ["played"], :name => "index_audio_files_on_played"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_features", :id => false, :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "feature_id",  :null => false
  end

  add_index "categories_features", ["category_id"], :name => "index_categories_features_on_category_id"
  add_index "categories_features", ["feature_id"], :name => "index_categories_features_on_feature_id"

  create_table "collections", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections_features", :id => false, :force => true do |t|
    t.integer "collection_id", :null => false
    t.integer "feature_id",    :null => false
  end

  add_index "collections_features", ["collection_id"], :name => "index_collections_features_on_collection_id"
  add_index "collections_features", ["feature_id"], :name => "index_collections_features_on_feature_id"

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_deleted",                     :default => false
    t.string   "name"
    t.string   "location"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["is_deleted"], :name => "index_comments_on_is_deleted"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "competition_awards", :force => true do |t|
    t.string   "title"
    t.integer  "edition_id"
    t.integer  "feature_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :default => 0
  end

  add_index "competition_awards", ["edition_id"], :name => "index_competition_awards_on_edition_id"
  add_index "competition_awards", ["feature_id"], :name => "index_competition_awards_on_feature_id"
  add_index "competition_awards", ["position"], :name => "index_competition_awards_on_position"

  create_table "competition_editions", :force => true do |t|
    t.string   "title"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",       :default => 0
  end

  add_index "competition_editions", ["competition_id"], :name => "index_competition_editions_on_competition_id"
  add_index "competition_editions", ["position"], :name => "index_competition_editions_on_position"

  create_table "competitions", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.boolean  "delta",              :default => true, :null => false
    t.integer  "position"
  end

  add_index "donors", ["position"], :name => "index_doners_on_position"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "short_description"
    t.string   "host"
    t.date     "e_date"
    t.date     "e_end_date"
    t.string   "location"
    t.boolean  "is_3rdcoastevent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.boolean  "delta",              :default => true,      :null => false
    t.string   "flavor",             :default => "regular"
    t.boolean  "deleted",            :default => false
  end

  add_index "events", ["deleted"], :name => "index_events_on_deleted"
  add_index "events", ["flavor"], :name => "index_events_on_flavor"

  create_table "extra_audio_files", :force => true do |t|
    t.text     "description"
    t.integer  "length"
    t.string   "mp3_file_name"
    t.string   "mp3_content_type"
    t.integer  "mp3_file_size"
    t.integer  "extra_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "extras", :force => true do |t|
    t.text     "behind_the_scene_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feature_id"
    t.text     "links_block"
  end

  create_table "feature_photos", :force => true do |t|
    t.integer  "feature_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "primary"
    t.string   "caption"
  end

  create_table "feature_spotlighted_dates", :force => true do |t|
    t.integer "feature_id"
    t.date    "date"
  end

  add_index "feature_spotlighted_dates", ["feature_id"], :name => "index_feature_spotlighted_dates_on_feature_id"

  create_table "features", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "origin_country"
    t.string   "premier_locaction"
    t.string   "premier_date"
    t.boolean  "published"
    t.string   "permalink"
    t.boolean  "delta",             :default => true, :null => false
  end

  add_index "features", ["published"], :name => "index_features_on_published"

  create_table "features_producers", :id => false, :force => true do |t|
    t.integer "feature_id",  :null => false
    t.integer "producer_id", :null => false
  end

  add_index "features_producers", ["feature_id"], :name => "index_features_producers_on_feature_id"
  add_index "features_producers", ["producer_id"], :name => "index_features_producers_on_producer_id"

  create_table "features_tags", :id => false, :force => true do |t|
    t.integer "feature_id", :null => false
    t.integer "tag_id",     :null => false
  end

  add_index "features_tags", ["feature_id"], :name => "index_features_tags_on_feature_id"
  add_index "features_tags", ["tag_id"], :name => "index__features_tags_on_tag_id"

  create_table "menu_items", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "weight"
    t.integer  "page_id"
    t.string   "page_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_items", ["page_id"], :name => "index_menu_items_on_page_id"
  add_index "menu_items", ["page_type"], :name => "index_menu_items_on_page_type"
  add_index "menu_items", ["parent_id"], :name => "index_menu_items_on_parent_id"
  add_index "menu_items", ["weight"], :name => "index_menu_items_on_weight"

  create_table "misc_audio_files", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "deleted",           :default => false
  end

  add_index "misc_audio_files", ["deleted"], :name => "index_misc_audio_files_on_deleted"

  create_table "misc_images", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "deleted",           :default => false
  end

  add_index "misc_images", ["deleted"], :name => "index_misc_images_on_deleted"

  create_table "news_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_3rdcoastnews", :default => false
    t.boolean  "delta",           :default => true,  :null => false
    t.boolean  "deleted",         :default => false
  end

  add_index "news_items", ["deleted"], :name => "index_news_items_on_deleted"

  create_table "page_dynamics", :force => true do |t|
    t.string   "slug_prefix"
    t.string   "slug"
    t.string   "controller"
    t.string   "action"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alternative_title"
  end

  create_table "page_parts", :force => true do |t|
    t.integer  "page_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_parts", ["name"], :name => "index_page_parts_on_name"
  add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"

  create_table "page_templates", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "template_id"
    t.boolean  "delta",             :default => true,  :null => false
    t.boolean  "published",         :default => false
    t.string   "alternative_title"
    t.string   "slug_prefix",       :default => ""
    t.string   "short_description"
  end

  add_index "pages", ["published"], :name => "index_pages_on_published"
  add_index "pages", ["slug"], :name => "index_pages_on_slug"
  add_index "pages", ["template_id"], :name => "index_pages_on_template_id"

  create_table "podcast_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "duration"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "deleted",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "producers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
    t.boolean  "deleted",    :default => false
  end

  add_index "producers", ["deleted"], :name => "index_producers_on_deleted"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "side_bar_tiles", :force => true do |t|
    t.string   "title"
    t.boolean  "deleted"
    t.integer  "displayed"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.string   "file_file_size"
    t.datetime "file_updated_at"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spotlights", :force => true do |t|
    t.string   "key"
    t.integer  "feature_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff_picks", :force => true do |t|
    t.string   "name"
    t.text     "blip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",      :default => true, :null => false
  end

  create_table "store_item_attribute_values", :force => true do |t|
    t.integer  "store_item_attribute_id"
    t.text     "attribute_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_item_attributes", :force => true do |t|
    t.text     "attribute_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "paypal"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "deleted",            :default => false
    t.integer  "position",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.string   "login",                                :null => false
    t.string   "email",                                :null => false
    t.string   "crypted_password",                     :null => false
    t.string   "password_salt",                        :null => false
    t.string   "persistence_token",                    :null => false
    t.integer  "login_count",       :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token",  :default => "",    :null => false
    t.boolean  "notify_email",      :default => false
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["notify_email"], :name => "index_users_on_notify_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
