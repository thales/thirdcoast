# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	
  def producer_for(feature)
    if feature.producers.length == 0
      return "N/A"
    elsif feature.producers.length == 1
      return feature.producers.first.name
    elsif feature.producers.length > 1
      output = ""
      feature.producers.each do |producer|
        if producer != feature.producers.first
          if producer == feature.producers.last
            output += ' & '
          else
            output += ', '
          end
        end
        
        output += producer.name
      end
      
      return output
    end
  end
  
  def photo_path
    if RAILS_ENV == 'production' 
      return "https://feature-photos.s3.amazonaws.com"
    else
      #return "https://dev-feature-photos.s3.amazonaws.com"
      return "https://feature-photos.s3.amazonaws.com"
    end
  end
  
  def toHHMM(input, minutes_to_00 = false, separator = ":")
    minutes = input / 60
    seconds = input % 60
    
    seconds = '0'+seconds.to_s if seconds < 10
    minutes = '0'+minutes.to_s if minutes_to_00 && minutes < 10
    
    "#{minutes}#{separator}#{seconds}"
  end

  def toHHMMSS(input, hours_to_00 = false, separator = ":")
    hours = input / 3600
    minutes = input / 60
    seconds = input - (hours * 3600 + minutes * 60)
    
    seconds = '0'+seconds.to_s if seconds < 10
    minutes = '0'+minutes.to_s if minutes < 10
    hours = '0'+ hours.to_s if hours_to_00 && hours < 10
    
    "#{hours}#{separator}#{minutes}#{separator}#{seconds}"
  end
  
  def options_collections
    collections = Collection.all
    
    array = collections.map{|item| ["#{item.name} (#{item.features.published.count})", item.id]}
    
    array = array.unshift(['Collections', ""]);
    
    options_for_select(array)
  end
  
  def options_categories
    collections = Category.all
    
    array = collections.map{|item| ["#{item.name} (#{item.features.published.count})", item.id]}
    
    array = array.unshift(['Categories', ""]);
    
    options_for_select(array)
  end
  
  def options_duration #in seconds
    array = [
      ['<10 minutes', '-600'],
      ['10-30 minutes', '600-1800'],
      ['30+ minutes', '1800-']
    ]
    
    array.unshift(['Duration', ""])
    
    options_for_select(array)
  end
  
  def display_tags_cloud(tags)
    output = ""
    
    tags.each_with_index do |tag, i|
      i = 4 if i >= 4
      
      output += "<div class='tag_in_cloud tag_in_cloud_size_#{i}'>#{link_to tag.spaceless_name, library_tag_url_helper(tag.name), :class => (tag.name == params[:tag] ? "selected" : nil)}</div>"
    end
    
    return output
  end
  
  def nl2br(input)
    input.gsub "\n", "<br>"
  end
  
  def opened_top?(menu_item)
    if @top_page && @top_page.menu_item && @top_page.menu_item.id == menu_item.id
      return true
    else
      page = PageDynamic.first :conditions => {:controller => params["controller"], :action => params["action"]}

      return true if page && page.menu_item.id == menu_item.id
    end
  end
  
  def opened_sub?(menu_item)
    if @page && @page.menu_item == menu_item
      return true
    else
      page = PageDynamic.first :conditions => {:controller => params["controller"], :action => params["action"]}
      
      return true if page && page.menu_item.id == menu_item.id
    end
  end
  
  def small_menu
    if @top_page && @top_page.menu_item
      @top_menu_item = @top_page.menu_item
    else
      params["action"] ||= "index"
      top_page = PageDynamic.first(:conditions => {:controller => params["controller"], :action => params["action"]})
      @top_menu_item = top_page.menu_item if top_page
    end
    
    if @top_menu_item
      filter_unpublished( @top_menu_item.children )
    else
      []
    end
  end

  def small_menu_in_path?(menu_item)
    paths = request.path.split('/')
    return paths.include?(menu_item.page.slug.to_s)
  end

  def small_menu_item(page, path, level = 0)
    path = "/#{page.path}"

    prefix = ""

    level.times { prefix += "_" }

    output = "<li>#{link_to prefix + page.title, path, :class => (opened_sub?(page) ? 'selected' : '') }</li>"

    if small_menu_in_path?(page)
      pages_scope = page.children
      
      pages_scope = filter_unpublished(pages_scope)
      
      pages_scope.each do |child|
        output += small_menu_item(child, path, level + 1)
      end
    end

    return output
  end
  
  def eval_erb(erb)
    decoded = HTMLEntities.new.decode(erb)
    
    render :inline => decoded
  end
  
  def parent_menu_items(selected)
    options = ""
    
    def make_option_for(menu_item, level, selected)
      return "" if menu_item.id == @item.id

      prefix = ""
      level.times{prefix += "- "}

      if selected && menu_item.id == selected.id
        is_selected = "selected"
      else
        is_selected = ""
      end

      output = "<option #{is_selected} value='#{menu_item.id}'>#{prefix} #{menu_item.title}</option>"

      menu_item.children.each do |child|
        output += make_option_for(child,level + 1, selected)
      end

      return output
    end

    MenuItem.roots.each do |menu_item|
      options += make_option_for(menu_item, 0, selected)
    end


    return options
  end
  
  def root_menu_items
    scope = MenuItem.roots
    
    scope =  filter_unpublished( scope )
    
    return scope
  end
  
  def current_spotlight
    if @weekly_spotlight.nil?
      spot = Spotlight.find_by_key('weekly')
      
      @weekly_spotlight = spot.feature unless spot.nil?
    end
    
    
    return @weekly_spotlight
  end  
  
  def page_title
    if @page_title
      return "Third Coast International Audio Festival :: " + @page_title
    elsif @page
      return "Third Coast International Audio Festival :: " + @page.parent_titles
    end
  end
  
  def filter_unpublished(array)
    array.delete_if{|item| !item.is_published?}
  end
  
  def truncate_feature_description(feature)
    output = feature.description.to_s
    
    p_end_lcoation = output.index "</p>"
    
    p_end_lcoation = output.index "</P>" if p_end_lcoation.nil?
    p_end_lcoation = output.index "</ p>" if p_end_lcoation.nil?
    p_end_lcoation = output.index "</ P>" if p_end_lcoation.nil?
    
    if p_end_lcoation
      output = output[0,p_end_lcoation]
    
      output = output.gsub /(&nbsp;|&nbsp| )+$/, "" 
      # output = output.gsub /(\.)+$/, "" 
    
      # output += " " + link_to("(more)", player_url(feature) + "?closed=true", :rel => 'playerPopup')+"</p>"
      output += " " + link_to("(more)", player_url(feature), :rel => 'playerPopup')+"</p>"
    end
    
    return output
  end
  
  def print_right_image
    if RIGHT_IMAGES.include? @rightimage
      image_name = "rightimage_#{@rightimage}.png"
    else
      image_name = "rightimage_home.png"
    end
    
    image_tag image_name, :class => 'rightimage'
  end
  
  def disply_class_name(obj)
    name = obj.class.to_s
    
    case name
      when "Feature"
        name = "Audio"
    end
    
    return name
  end
  
  def clippy(text, bgcolor='#FFFFFF')
    html = <<-EOF
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              id="clippy" >
      <param name="movie" value="/flash/clippy.swf"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="text=#{text}">
      <param name="bgcolor" value="#{bgcolor}">
      <embed src="/flash/clippy.swf"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="text=#{text}"
             bgcolor="#{bgcolor}"
      />
      </object>
    EOF
  end
end
