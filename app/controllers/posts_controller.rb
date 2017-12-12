class PostsController < ApplicationController
  before_action :authenticate_user!
  def new
	@post = Post.new 
  end 

  def index
    @posts = Post.all
  end
  def edit
    @post=Post.find(params[:id])
  end
  def update
    @post=Post.find(params[:id])
    if @post.update( permit_post )
      redirect_to @post
    else
      render 'edit'
    end

  end
  def show
    @post = Post.find(params[:id])
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
        redirect_to posts_path
        flash[:success] = "The post is destroy!"
    else
      redirect_to posts_path
    end
  end
  def create
  	@post = Post.new( permit_post )
  	if @post.save
  		flash[:success] = "Success!"
  		redirect_to post_path(@post)
  	else
  		flash[:error] = @post.errors.full_messages
  		redirect_to new_post_path
  	end
  end
  private
  		def permit_post
  			params.require(:post).permit(:image,:description)
  		end
end
