class NotificationsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    @notifications = current_user.notifications
    $notifications_count = @notifications.count
  end

  def destroy
    @notification = Notification.find(params[:id])
    authorize @notification
    @notification.destroy
    redirect_to :back
  end
end
