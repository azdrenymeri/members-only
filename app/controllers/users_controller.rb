class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
      @user = User.new(user_params)

      if @user.save
        flash[:success] = "User Created"
        login @user
        redirect_to root_url
      else
        render 'new'
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile successfully updated!"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
