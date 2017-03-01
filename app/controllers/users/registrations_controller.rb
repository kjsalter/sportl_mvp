class Users::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    my_profile_edit_path
  end

end
