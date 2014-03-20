class AddFeaturesTagsJoin < ActiveRecord::Migration
  def self.up
    create_table :features_tags, :id => false do |t|
	t.integer   :feature_id, :null => false
  	t.integer   :tag_id, :null => false

    end
    add_index "features_tags", ["tag_id"], :name => "index__features_tags_on_tag_id"
    add_index "features_tags", ["feature_id"], :name => "index_features_tags_on_feature_id"    
  end

  def self.down
  end
end
