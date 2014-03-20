class CommentsController < ApplicationController
  def create
    if verify_recaptcha
      @feature = Feature.published.find params[:player_id]

      @comment = @feature.comments.create(params[:comment])

      render :partial => 'player/comment', :object=>@comment
    else
      render :text => '--bad captcha--'
    end
  end
end