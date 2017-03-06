module NotificationsHelper
  def time_from_today(notification)
    if (Time.now - notification.created_at) < 60
      "A few seconds ago"
    elsif ((Time.now - notification.created_at)/(60)) < 60
      "#{((Time.now - notification.created_at)/(60)).round(0)} minutes ago"
    elsif ((Time.now - notification.created_at)/(60*60)) < 24
      "#{((Time.now - notification.created_at)/(60*60)).round(0)} hours ago"
    else
      "#{((Time.now - notification.created_at)/(60*60*24)).round(0)} days ago"
    end
  end
end
