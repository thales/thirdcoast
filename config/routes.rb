ActionController::Routing::Routes.draw do |map|
  Jammit::Routes.draw(map)

  map.map "/podcast_feed.rss", :controller => "podcast_feed", :action => "index"

  map.map "/about-tciaf/shoppe", :controller=>"shoppe", :action=>"index"

  map.library '/library/tag/:tag/year/:year/page/:page', :controller => 'library', :action => 'index'
  map.library '/library/tag/:tag/year/:year', :controller => 'library', :action => 'index'
  map.library '/library/tag/:tag/order/:order_by/:begins_with/page/:page', :controller => 'library', :action => 'index'
  map.library '/library/tag/:tag/order/:order_by/:begins_with', :controller => 'library', :action => 'index'
  map.library '/library/order/:order_by/:begins_with/age/:page', :controller => 'library', :action => 'index'
  map.library '/library/order/:order_by/:begins_with', :controller => 'library', :action => 'index'
  map.library '/library/tag/:tag/order/:order_by/page/:page', :controller => 'library', :action => 'index'
  map.library '/library/tag/:tag/order/:order_by', :controller => 'library', :action => 'index'
  map.library '/library/order/:order_by/page/:page', :controller => 'library', :action => 'index'
  map.library '/library/order/:order_by', :controller => 'library', :action => 'index'
  map.library '/library/tag/:tag/page/:page', :controller => 'library', :action => 'index'
  map.library '/library/tag/:tag', :controller => 'library', :action => 'index'
  map.library '/library/page/:page', :controller => 'library', :action => 'index'
  map.library '/library', :controller => 'library', :action => 'index'
  
  map.library_collection '/library/collections/:id/tag/:tag/order/:order_by/:begins_with/page/:page', :controller => 'library', :action => 'collections'
  map.library_collection '/library/collections/:id/tag/:tag/order/:order_by/:begins_with', :controller => 'library', :action => 'collections'
  map.library_collection '/library/collections/:id/order/:order_by/:begins_with/page/:page', :controller => 'library', :action => 'collections'
  map.library_collection '/library/collections/:id/order/:order_by/:begins_with', :controller => 'library', :action => 'collections'
  map.library_collection '/library/collections/:id/tag/:tag/order/:order_by/page/:page', :controller => 'library', :action => 'collections'
  map.library_collection '/library/collections/:id/tag/:tag/order/:order_by', :controller => 'library', :action => 'collections'
  map.library_collection '/library/collections/:id/order/:order_by/page/:page', :controller => 'library', :action => 'collections'
  map.library_collection '/library/collections/:id/order/:order_by', :controller => 'library', :action => 'collections'
  
  map.library_collection '/library/collections/:id/tag/:tag/page/:page', :controller => 'library', :action => 'collections'
  map.podlibrary_collection '/library/collections/:id/tag/:tag', :controller => 'library', :action => 'collections'
  map.library_collection '/library/collections/:id/page/:page', :controller => 'library', :action => 'collections'
  map.library_collection '/library/collections/:id', :controller => 'library', :action => 'collections'
  
  map.library_collection_year '/library/collections/:id/tag/:tag/year/:year/page/:page', :controller => 'library', :action => 'collections'
  map.library_collection_year '/library/collections/:id/tag/:tag/year/:year', :controller => 'library', :action => 'collections'
  map.library_collection_year '/library/collections/:id/year/:year/page/:page', :controller => 'library', :action => 'collections'
  map.library_collection_year '/library/collections/:id/year/:year', :controller => 'library', :action => 'collections'
  
  map.library_year '/library/year/:year/page/:page', :controller => 'library', :action => 'index'
  map.library_year '/library/year/:year', :controller => 'library', :action => 'index'
  
  map.library_producer_year '/library/producers/:id/tag/:tag/year/:year/page/:page', :controller => 'library', :action => 'producer_show'
  map.library_producer_year '/library/producers/:id/tag/:tag/year/:year', :controller => 'library', :action => 'producer_show'
  map.library_producer_year '/library/producers/:id/year/:year/page/:page', :controller => 'library', :action => 'producer_show'
  map.library_producer_year '/library/producers/:id/year/:year', :controller => 'library', :action => 'producer_show'
  
  map.library_search '/library/search/tag/:tag/page/:page', :controller => 'library', :action => 'search'
  map.library_search '/library/search/tag/:tag', :controller => 'library', :action => 'search'
  map.library_search '/library/search/page/:page', :controller => 'library', :action => 'search'
  map.library_search '/library/search', :controller => 'library', :action => 'search'
  
  map.library_producers '/library/producers/az/:begins_with/page/:page', :controller => 'library', :action => "producers_index"
  map.library_producers '/library/producers/az/:begins_with', :controller => 'library', :action => "producers_index"
  map.library_producers '/library/producers/page/:page', :controller => 'library', :action => "producers_index"
  map.library_producers '/library/producers', :controller => 'library', :action => "producers_index"
  
  map.library_producer '/library/producers/:id/tag/:tag/order/:order_by/:begins_with/page/:page', :controller => 'library', :action => 'producer_show'
  map.library_producer '/library/producers/:id/tag/:tag/order/:order_by/:begins_with', :controller => 'library', :action => 'producer_show'
  map.library_producer '/library/producers/:id/order/:order_by/:begins_with/page/:page', :controller => 'library', :action => 'producer_show'
  map.library_producer '/library/producers/:id/order/:order_by/:begins_with', :controller => 'library', :action => 'producer_show'
  map.library_producer '/library/producers/:id/tag/:tag/order/:order_by/page/:page', :controller => 'library', :action => 'producer_show'
  map.library_producer '/library/producers/:id/tag/:tag/order/:order_by', :controller => 'library', :action => 'producer_show'
  map.library_producer '/library/producers/:id/order/:order_by/page/:page', :controller => 'library', :action => 'producer_show'
  map.library_producer '/library/producers/:id/order/:order_by', :controller => 'library', :action => 'producer_show'
  
  map.library_producer '/library/producers/:id/tag/:tag/page/:page', :controller => 'library', :action => 'producer_show'
  map.library_producer '/library/producers/:id/tag/:tag', :controller => 'library', :action => 'producer_show'
  
  map.library_producer '/library/producers/:id/page/:page', :controller => 'library', :action => "producer_show"
  map.library_producer '/library/producers/:id', :controller => 'library', :action => "producer_show"
  
  map.library_feed_recent '/library/feeds/recent', :controller => 'library', :action => "feed_recent"
  map.library_feed_resound '/library/feeds/resound', :controller => 'library', :action => "feed_resound"
  
  # map.admin  '/admin',  :controller => "admin/admin", :action => 'index'
  map.admin  '/admins_panel',  :controller => "admin/admin", :action => 'index'
  map.search   '/search',  :controller => "home", :action => 'search'
  
  map.embed '/embed', :controller => "home", :action => "embed"

  map.root :controller => 'home', :action => "index"

  map.resources :player, :as =>"library", :member => [:print] do |player|
    player.resources :comments, :only => [:create]
  end

  map.events_month '/calendar/:year/:month', :controller => 'events'

  map.resources :events, :as => 'calendar', :only => [:index]

  map.set_primary_photo  "/set_primary_photo",
                          :controller => 'javascript',
                          :action => 'set_primary_photo'


  map.namespace :admin, :path_prefix => "admins_panel" do |admin|
    admin.resources :features, :has_one => [:extra], :has_many => [:categories, :feature_photos, :tags, :producers], :collection => {:auto_complete_for_producer_name => :get, :search => :get, :autocomplete_name => :get}, :member => [:pre_delete] do |admin_feature|
      admin_feature.resource :audio_file, :member => [:set_downloadable ]
      admin_feature.resources :comments, :only => [:index], :member => [:delete, :undelete]
      admin_feature.remove_producer "producers/remove/:producer_id", :controller => "features", :action => "remove_producer"
    end
    
    admin.resources :feature_photos
    admin.resources :audio_files
    admin.resources :extras, :has_many => :extra_audio_files
    admin.resources :extra_audio_files
    admin.resources :producers
    admin.resources :categories
    admin.resources :collections
    admin.resources :tags
    admin.resources :airings, :collection => [:feature_name]
    
    admin.resources :pages, :member => [:rebuild, :rebuild_do, :delete, :delete_do]
    admin.resources :events
    admin.resources :news_items
    admin.resources :users
    admin.resource :user_session
    admin.resources :password_resets
    admin.resources :passwords, :only  => [:edit, :update]
    admin.resources :donors, :collection => [:reorder, :reorder_save]
    admin.resources :staff_picks
    
    admin.resources :menu, :collection => [:reorder_save]
    
    admin.resource :spotlights, :member => [:feature_name]
    
    admin.resources :misc_audio_files, :only => [:new, :create, :index, :destroy]
    admin.resources :misc_images, :only => [:new, :create, :index, :destroy]

    admin.resources :page_templates

    admin.resources :podcast_items
    
    admin.resources :side_bar_tiles

    admin.resources :store_items, :collection => [:reorder_save]

    admin.edit_links_block            'extras/:feature_id/:extra_id/edit_links_block',
      :controller => "extras",
      :action => "edit_links_block"

    admin.update_links_block          '/update_links_block',
      :controller => 'extras',
      :action => "update_links_block"
      
    admin.resources :competitions, :collection => [:award_feature_name] do |competition|
      competition.resources :editions, :controller => "competition_editions", :collection => [:reorder_save] do |edition|
        edition.resources :awards, :controller => "competition_awards", :collection => [:reorder_save]
      end
    end
  end
  
  map.resources :pages, :only => [], :member => "preview"

  map.connect '*path', :controller => 'pages', :action => 'show'

end
