class SessionsController < ApplicationController

    def new
    end


    def create
      
      user = User.find_by_email(params[:session][:email])


      if user && user.authenticate(params[:session][:password])

        if params[:remember_me]
          cookies.permanent[:auth_token]  = user.auth_token
        else
          cookies[:auth_token]  = user.auth_token
        end
        flash[:success] = "User logged in successfully"
      redirect_to root_url
    else
      flash[:danger] = "Something went wrong please try it again"
      render 'new'
    end

  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url
  end

end
