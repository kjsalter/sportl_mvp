module ApplicationHelper
  def params_for_event_index(args = {})
    hash_new = {missing_player: params[:missing_player], sports: params[:sports], start_time: params[:start], end_time: params[:end], location: params[:location], radius: params[:radius] }
    hash_new.merge(args)
  end

  def levels_list
    levels = %w(Any 1-beginner 2 3 4 5-advanced)
    levels.map.with_index do |lvl, index|
      [lvl, index]
    end
  end
end
