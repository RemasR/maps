module Users
  class SessionsController < Devise::SessionsController
    protected

    def after_sign_in_path_for(resource)
      locations_path # Change to the path where you want to redirect
    end
  end
end