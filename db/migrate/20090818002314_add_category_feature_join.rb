class AddCategoryFeatureJoin < ActiveRecord::Migration
  def self.up
    create_table :categories_features, :id => false do |t|
  	t.integer   :category_id, :null => false
	t.integer   :feature_id, :null => false

    end
    add_index "categories_features", ["category_id"], :name => "index_categories_features_on_category_id"
    add_index "categories_features", ["feature_id"], :name => "index_categories_features_on_feature_id"
    
  end

  def self.down
  end
end
