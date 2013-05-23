class LikesController < ApplicationController

	before_filter :require_user
	before_filter :find_post

	def create
		unless current_user == @post.user
			@post.likes.create(user_id: current_user.id) 
			flash[:alert] = "You liked this post"
		else
			flash[:error] = "You can't like your own post"
		end
		
		redirect_to post_path(@post)
	end

	def destroy
		# find all the likes by that user on that post and remove them
		@post.likes.where(user_id: current_user.id).destroy_all

		flash[:alert] = "You unliked this post"

		redirect_to post_path(@post)
	end

	def find_post
		@post = Post.find_by_url(params[:post_id])
	end


end
