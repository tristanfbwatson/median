class PostsController < ApplicationController

  before_filter :require_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :find_post, only: [:edit, :update, :destroy]

  def index

    #if there's a ?tag=something in the url
    if params[:tag].present?

      #get posts filtered by tag
      @featured  = Post.featured.tagged_with(params[:tag])
      @posts = Post.not_featured.tagged_with(params[:tag])

    else

    # otherwise get everything
    @featured = Post.featured
    @posts = Post.not_featured

    end

    # Get tags list
    @tags = Post.tag_counts.order("count desc").limit(5)

  end

  def show
    @post = Post.find_by_url(params[:id])
  end

  def new
    require_user

    # create a form for the current user adding a new post
    @post = current_user.posts.new

  end


  def create
    require_user
    @post = current_user.posts.new(params[:post])

    if @post.save
      flash[:alert] = "Yay you've added a post"
      redirect_to post_path(@post)
    else
      render "new"
    end

  end

  def edit
  end

  def update
    if @post.update_attributes(params[:post])
      flash[:alert] = "Post Edited"
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    flash[:alert] = "Post deleted"
    redirect_to root_path
  end



  def find_post
    @post = current_user.posts.find_by_url(params[:id])
    rescue
      flash[:error] = "You're not authorised to edit this"
      redirect_to root_path
  end


end
