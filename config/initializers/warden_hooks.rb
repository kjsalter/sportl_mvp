Warden::Manager.after_set_user do |user,auth,opts|
  Rails.logger.debug "USER - #{user.id}"
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = user.id
end
