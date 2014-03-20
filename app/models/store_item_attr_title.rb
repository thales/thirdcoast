class StoreItemAttrTitle < ActiveRecord::Base
	belongs_to		:store_item
	has_many		:store_item_attr_vals,  :dependent => :destroy
  #accepts_nested_attributes_for	:store_item_attr_vals
  #attr_accessible	:store_item_attr_title, :store_item_attr_vals_attributes
end
