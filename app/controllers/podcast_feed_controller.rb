class PodcastFeedController < ApplicationController
  caches_page :index

  def index
    @podcast_items = PodcastItem.ordered.all(:limit => 40)

    render "index.rss.builder", :layout => false, :content_type => "application/rss+xml"
  end
end
