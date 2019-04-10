class SessionsController < ApplicationController

    def new
        if logged_in?
            redirect_to root_url
        end
    end


    def create
        @user = User.find_by(email:params[:session][:email])
        if @user and @user.authenticate(params[:session][:password])
            login @user
            remember @user
            flash[:success] = "You are Logged In"
            redirect_to root_url
        end
    end

    def destroy
        
        if logged_in?
            log_out
        end
        redirect_to root_url
    end
end
