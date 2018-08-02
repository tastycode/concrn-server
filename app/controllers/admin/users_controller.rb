class Admin::UsersController < Admin::Controller
  MODEL = User
  PERMITTED_PARAMS = %i(name phone email password role affiliate_id)
  DEFAULT_SORT = "name asc"
  default_actions

  def default_serializer_options
    {
      include: %w(affiliate responder)
    }
  end

  def default_scope
    current_user.affiliate? ?
      current_user.affiliate.users :
      User.all
  end
end
