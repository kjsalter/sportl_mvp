module ApplicationHelper
  def params_for_event_index(args = {})
    hash_new = {missing_player: params[:missing_player], sports: params[:sports], start_time: params[:start], end_time: params[:end], location: params[:location], radius: params[:radius] }
    hash_new.merge(args)
  end
end
