class StaticPagesController < ApplicationController
  def home
    # @micropost = Micropost.new(user_id: current_user.id)
    @micropost = current_user.microposts.build if logged_in?
  end

  def help
  end

  def about
    
  end
end
