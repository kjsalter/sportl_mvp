class ProfilesController < ApplicationController
before_action :authenticate_user!, only: [:edit, :update]
  def my_profile
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.username = params[:user][:username]
    @user.bio = params[:user][:bio]
    @user.photo = params[:user][:photo]
    @user.sports = params[:user][:likes]


    if @user.save
      redirect_to my_profile_path
    else
      render :new
    end

  end
end
