class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authenticated?(:activation_digest, params[:id])
      @user.update_columns(:activated, true)
      @user.update_columns(:activated_at, Time.zone.now)
      log_in @user
      flash[:success] = 'Account activated!'
      redirect_to @user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
end
