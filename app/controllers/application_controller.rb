class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    def current_user
        
        if(user_id = session[:user_id])
            @current_user  ||= User.find(user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find(user_id)

            if user && user.authenticated?(cookies[:remember_token])
                login user
                @current_user = user
            end

        end
    end
end
