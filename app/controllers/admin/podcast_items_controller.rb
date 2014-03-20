class Admin::PodcastItemsController < Admin::ApplicationController
  layout 'admin'

  def index
    @podcast_items = PodcastItem.ordered.paginate :page => params[:page], :per_page => 20
  end

  def new
    @podcast_item = PodcastItem.new
  end

  def create
    @podcast_item = PodcastItem.new params[:podcast_item]

    if params[:podcast_item][:file]
      mp3info = Mp3Info.open(params[:podcast_item][:file].path)  

      @podcast_item.duration = mp3info.length
    end

    if @podcast_item.save
      clear_feed_cache
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def edit
    @podcast_item = PodcastItem.find params[:id]
  end

  def update
    @podcast_item = PodcastItem.find params[:id]

    if params[:podcast_item][:file]
      mp3info = Mp3Info.open(params[:podcast_item][:file].path)  

      @podcast_item.duration = mp3info.length
    end

    if @podcast_item.update_attributes params[:podcast_item]
      clear_feed_cache
      redirect_to :action => "index"
    else
      render "edit"
    end
  end

  def destroy
    @podcast_item = PodcastItem.find params[:id]

    @podcast_item.deleted = true
    @podcast_item.save!

    clear_feed_cache
    
    redirect_to :action => :index
  end

    protected

      def clear_feed_cache
        expire_page "/podcast_feed.rss"
      end
end
