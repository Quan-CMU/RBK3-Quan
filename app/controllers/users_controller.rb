class UsersController < ApplicationController

  def index
    @user = User.new
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
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now[:success] = 'Update success!!'
      redirect_to @users
    else
      render 'edit'
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
end
