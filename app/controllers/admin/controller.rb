module Admin
  class Controller < ApplicationController
    before_action :require_auth

    def require_admin
      head :forbidden unless current_user.roles.include?("admin")
    end
  end
end
