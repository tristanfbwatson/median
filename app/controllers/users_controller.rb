class UsersController < ApplicationController
  def show
      @user = User.find_by_username(params[:id])
  end

  def new
  		@user = User.new
  end

  def create
  		@user = User.new(params[:user])

  		if @user.save
  			# Save the user's id to our browser to mean we're logged in
  			session[:user_id] = @user.id

  			flash[:alert] = "Yay, you've signed up"
  			redirect_to root_path
  		else
  			render "new"
  		end
  end

end
