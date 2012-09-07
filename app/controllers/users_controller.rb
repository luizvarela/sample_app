class UsersController < ApplicationController
  
  def new
  	@user = User.new(params[:user])
  end

  def show
  	@user = User.find(params[:id])	
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to sample App!"
      # if user save then redirect to users page
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
  
end