class ProfilesController < ApplicationController
skip_after_action :verify_authorized

  def my_profile
    @user = current_user

    @hash = Gmaps4rails.build_markers([@user]) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end

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
    @user.address = params[:user][:address]
    # @user.sports = params[:user][:likes]


    if @user.save
      redirect_to my_profile_path
    else
      render :new
    end
  end

  private

  # def booking_params
  #   params.require(:profile).permit(:booking_state)
  # end
end
