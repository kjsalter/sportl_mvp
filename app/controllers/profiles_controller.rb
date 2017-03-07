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

    @hash = Gmaps4rails.build_markers([@user]) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def edit
    @user = current_user

  end

  def update
    @user = current_user
    @user.update(user_params)

    if @user.save
      redirect_to my_profile_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :bio, :photo, :address, :likes, sport_ids: [])
  end
end
