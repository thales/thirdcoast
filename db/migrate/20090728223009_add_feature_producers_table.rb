class AddFeatureProducersTable < ActiveRecord::Migration
  def self.up
    create_table :features_producers, :id => false do |t|
      t.integer   :feature_id, :null => false
      t.integer   :producer_id, :null => false
    end
    add_index "features_producers", ["feature_id"], :name => "index_features_producers_on_feature_id"
    add_index "features_producers", ["producer_id"], :name => "index_features_producers_on_producer_id"
  end

  def self.down
  end
end
