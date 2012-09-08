class UsersController < ApplicationController
   before_filter :signed_in_user, only: [:index, :edit, :update]
   before_filter :signed_in_user, only: [:edit, :update]
   before_filter :correct_user,   only: [:edit, :update]
   
  def index
    @users = User.paginate(page: params[:page])
  end
   
  def new
  	@user = User.new(params[:user])
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
        flash[:success] = "Profile update"
        sign_in @user
        redirect_to @user    
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])  
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  private
        
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless correct_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless correct_user.admin?
    end
  
end