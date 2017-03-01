module ApplicationHelper
  def params_for_event_index(args = {})
    hash_new = {sports: params[:sports], start: params[:start], end: params[:end], location: params[:location], radius: params[:radius] }
    hash_new.merge(args)
  end
end
