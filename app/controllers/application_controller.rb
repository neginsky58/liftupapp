class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
	 show_user_path(current_user.permalink)
  end

end
