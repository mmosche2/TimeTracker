class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
		#login user
		cookies[:auth_token] = @user.auth_token
		
		#Send the user an email when they create their account
		UserMailer.welcome_email(@user).deliver
		
		#redirect on success
        redirect_to @user, notice: 'User was successfully created.' 
    else
       render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
        redirect_to @user, notice: 'User was successfully updated.'
    else
        render action: "edit"
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end
  
end
