class PostsController < ApplicationController
    before_action :logged_in_user, except: [:index, :show]
    before_action :correct_user, only: [:edit, :update, :destroy, :show]
  

    def index
        @posts = Post.order(updated_at: :desc) 
    end

    def new
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
        @user = User.find(@post.user_id)
        @correct_user = current_user.id == @user.id
    end

    def edit
        @post = Post.find(params[:id])
      end
    
      def update
        @post = Post.find(params[:id])
        if @post.update_attributes(post_params)
          flash[:success] = "Post updated."
          redirect_to @post
        else
          render 'edit'
        end
      end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Successfully posted!"
            redirect_to posts_path
        else
            render 'new'
        end
    end

    def destroy
        @post.destroy
        flash[:success] = "Post successfully deleted!"
        redirect_to posts_path
    end

    private

        def post_params
            params.require(:post).permit(:id,:title, :description)
        end
        
        def logged_in_user
            unless logged_in?
            flash[:danger] = "Please log in!"
            redirect_to login_path
            end
        end
        def correct_user
            @post = Post.find(params[:id])
            user = @post.user
            redirect_to(root_url) unless (current_user?(user) || current_user.admin?)
        end

end
