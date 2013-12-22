class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    show_user_path(current_user.permalink)
  end
end

