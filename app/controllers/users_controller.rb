class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update index]
  before_action :correct_user, only: %i[edit update]

  def index
    @user = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def create
    @user = User.new (user_params)
    if @user.save
      log_in(@user)
      flash.now[:success] = "Sign Up Success!"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
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

  def delete
    
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
