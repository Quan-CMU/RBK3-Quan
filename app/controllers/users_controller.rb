class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update index destroy]
  before_action :correct_user,   only: %i[edit update]
  before_action :admin_user,     only: %i[destroy]
  # USER_PER_PAGE = 10

  def index
    # @users = User.all
    # panigration with gem
    @users = User.page(params[:page])
    # panigration without gem
    # @page = params.fetch(:page, 1).to_i
    # @users = User.offset(@page*USER_PER_PAGE).limit(USER_PER_PAGE)
    # @users = User.where(activated: FILL_IN).paginate(page: params[:page])
  end
  
  def show
    @user = User.find_by(id: params[:id])
    # redirect_to root_url and return unless FILL_IN
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def create
    @user = User.new (user_params)
    if @user.save
      # log_in(@user)
      # flash.now[:success] = "Sign Up Success!"
      # redirect_to @user
      @user.send_activation_email
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash.now[:success] = 'Update success!!'
      redirect_to @user
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      flash[:success] = "Deleted!!!"
    else
      flash[:danger] = "Delete fail!!" 
    end
    redirect_to users_path
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :birthday, :gender, :phone, :password, :password_confirmation)
    end
  
  private
    
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end

  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
