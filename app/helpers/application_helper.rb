module ApplicationHelper
  def params_for_event_index(args = {})
    hash_new = {missing_player: params[:missing_player], sports: params[:sports], start_time: params[:start], end_time: params[:end], location: params[:location], radius: params[:radius] }
    hash_new.merge(args)
  end


  def gravatar_for(user, opts = {})
    opts[:alt] = user.first_name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
    opts
  end

  def levels_list
    levels = %w(Any 1-beginner 2 3 4 5-advanced)
    levels.map.with_index do |lvl, index|
      [lvl, index]
    end
  end

  def users_list
    usernames = []

    User.all.each do |user|
      usernames << user.username if user != current_user
    end

    return usernames
  end
  
  def party_size
    ['Party size', 1, 2, 3, 4, 5]
  end

  def sports_list
    Sport.joins(:events).pluck(:name)
  end
end
