class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    #for search bar
    @user = current_user
    @sports = Sport.all
    @events = Event.all
    @sports_list = @events.map { |event| event.sport.name }.uniq
    @sports_list.unshift("All sports")
    @party_size = ['Party size', 1, 2, 3, 4, 5]

    if user_signed_in?
      if @user.username == "" || @user.username.nil?
        flash[:alert] = "You have not yet created your profile - <a href='#{my_profile_edit_path}'>do this now 😎</a>"
      end
    end
  end
end
