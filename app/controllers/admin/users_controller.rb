class Admin::UsersController < Admin::Controller
  MODEL = User
  PERMITTED_PARAMS = %i(name phone email password)
  DEFAULT_SORT = "name asc"
  default_actions
end
