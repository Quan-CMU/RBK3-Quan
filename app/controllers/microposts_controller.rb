class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    if @micropost.destroy
      flash[:success] = 'Micropost deleted'
    else
      flash[:danger] = 'Deleted fail'
    end
    redirect_to request.referrer || root_url
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    return if @micropost
  
    flash[:danger] = 'the micropost doesn\'t exist'
    redirect_to root_url
  end
  

  private

    def micropost_params
      params.require(:micropost).permit(:content,:image)
    end
end
