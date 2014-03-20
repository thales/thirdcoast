class Admin::StoreItemsController < Admin::ApplicationController
  layout 'admin'

  skip_before_filter :verify_authenticity_token, :only => [:reorder_save]

  def index
    @store_items = StoreItem.all
  end

  def new
    @store_item = StoreItem.new
  end

  def create
    @store_item = StoreItem.new params[:store_item]
    if @store_item.save
			@store_item_attr1 = @store_item.store_item_attr_titles.create(:title => params[:store_item_attr_title][:title1])
			@store_item_attr1.store_item_attr_vals.create(:val => params[:store_item_attr_val][:val1])
			@store_item_attr1.store_item_attr_vals.create(:val => params[:store_item_attr_val][:val2])
			@store_item_attr1.store_item_attr_vals.create(:val => params[:store_item_attr_val][:val3])
		
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def edit
    @store_item = StoreItem.find params[:id]
  end

  def update
    @store_item = StoreItem.find params[:id]
    
#    params[:store_item_attr_title].each_with_index do |(title_key, title_value), title_index|
#			if title_key != "a" and title_key != "b" and title_key != "c"
#					# we have a title value already no need to create a new one in the db
#					# so we'll be updating or creating new title attribute values
#					if title_key.split("-")[0] == "a"
#						# if the title we want to add a value to is title "a" then only attach title "a" values
#						params[:store_item_attr_val].each_with_index do |(val_key, val_value), val_index|
#							if val_key != "a" and val_key.split("-")[0] == "a"
#								# update attribute value
#								StoreItemAttrVal.find_by_id(val_key.split("-")[1]).update_attribute(:val, val_value)
#							elsif val_key == "a"
#								params[:store_item_attr_val][:a].each_with_index do |val, idx|
#									# create attribute value
#									@store_item.store_item_attr_titles.find_by_id(title_key.split("-")[1]).store_item_attr_vals.create(:val => val[1]) unless val[1].nil? or val[1].blank?
#								end
#							end
#						end
#					elsif title_key.split("-")[0] == "b"
#						params[:store_item_attr_val].each_with_index do |(val_key, val_value), val_index|
#							if val_key != "b" and val_key.split("-")[0] == "b"
#								# update attribute value
#								StoreItemAttrVal.find_by_id(val_key.split("-")[1]).update_attribute(:val, val_value)
#							elsif val_key == "b"
#								params[:store_item_attr_val][:b].each_with_index do |val, idx|
#									# create attribute value
#									@store_item.store_item_attr_titles.find_by_id(title_key.split("-")[1]).store_item_attr_vals.create(:val => val[1]) unless val[1].nil? or val[1].blank?
#							end
#						end
#					elsif title_key.split("-")[0] == "c"
#						params[:store_item_attr_val].each_with_index do |(val_key, val_value), val_index|
#							if val_key != "c" and val_key.split("-")[0] == "c"
#								# update attribute value
#								StoreItemAttrVal.find_by_id(val_key.split("-")[1]).update_attribute(:val, val_value)
#							elsif val_key == "c"
#								params[:store_item_attr_val][:c].each_with_index do |val, idx|
#									# create attribute value
#									@store_item.store_item_attr_titles.find_by_id(title_key.split("-")[1]).store_item_attr_vals.create(:val => val[1]) unless val[1].nil? or val[1].blank?
#							end
#						end
#					end
#					@store_item.store_item_attr_titles.find_by_id(title_key.split("-")[1]).update_attribute(:title, title_value)
#			elsif title_key == "a"
#				# we have a title to create therefore we'll be creating all necessary new title values never updating.
#				@new_store_item_attr_title = @store_item.store_item_attr_titles.create(:title => params[:store_item_attr_title][:a])
#				params[:store_item_attr_val][:a].each do |val|
#					@new_store_item_attr_title.store_item_attr_vals.create(:val => val)
#				end
#			elsif title_key == "b"
#				@new_store_item_attr_title = @store_item.store_item_attr_titles.create(:title => params[:store_item_attr_title][:b])
#				params[:store_item_attr_val][:b].each do |val|
#					@new_store_item_attr_title.store_item_attr_vals.create(:val => val)
#				end
#			elsif title_key == "c"
#				@new_store_item_attr_title = @store_item.store_item_attr_titles.create(:title => params[:store_item_attr_title][:c])
#				params[:store_item_attr_val][:c].each do |val|
#					@new_store_item_attr_title.store_item_attr_vals.create(:val => val)
#				end
#			end
#		end
#	end
	
    if @store_item.update_attributes params[:store_item]
      redirect_to :action => "index"
    else
      render "edit"
    end
  end

  def destroy
    @store_item = StoreItem.find params[:id]

    @store_item.deleted = true
    @store_item.save!

    redirect_to :action => :index
  end

  def reorder_save
    params[:items].each_with_index do |item_id, position|
      item = StoreItem.find item_id
      item.position = position
      item.save!
    end
    
    redirect_to admin_store_items_path
  end
end