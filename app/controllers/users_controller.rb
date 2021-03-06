class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def show
    @user = User.new(params[:id])
  end
  


  
  def create
      @user = User.new(user_params)

      if @user.save
        flash[:success] = "User Successfully created"
         session[:user_id] = @user.id
        redirect_to root_url
      else
        flash[:danger] = "Somthing went wrong"
        render 'new'
      end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
