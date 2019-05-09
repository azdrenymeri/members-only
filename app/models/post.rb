class Post < ApplicationRecord
  belongs_to :user

  validates :title,presence:true,length:{minimum:2,maximum:50}
  validates :description,presence:true,length:{minimum:10}
  

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
end
