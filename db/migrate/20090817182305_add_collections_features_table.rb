class AddCollectionsFeaturesTable < ActiveRecord::Migration
  def self.up
    create_table :collections_features, :id => false do |t|
  	t.integer   :collection_id, :null => false
	t.integer   :feature_id, :null => false

    end
    add_index "collections_features", ["collection_id"], :name => "index_collections_features_on_collection_id"
    add_index "collections_features", ["feature_id"], :name => "index_collections_features_on_feature_id"
  
  end

  def self.down
  end
end
