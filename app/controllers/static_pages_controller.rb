class StaticPagesController < ApplicationController
  def home
    # @micropost = Micropost.new(user_id: current_user.id)
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page])
    end
  end

  def help
  end

  def about
    
  end
end
