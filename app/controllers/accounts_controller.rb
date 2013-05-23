class AccountsController < ApplicationController

  # Make sure we're signed in
  before_filter :require_user

  def edit
  	@user = current_user
  end

  def update
  	@user = current_user

  	if @user.update_attributes(params[:user])
  		flash[:alert] = "You've updated your profile"
  	end

  	render "edit"

  end



end
