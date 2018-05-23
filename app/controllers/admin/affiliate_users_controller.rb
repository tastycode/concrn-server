class Admin::AffiliateUsersController < Admin::Controller
  MODEL = AffiliateUser
  PERMITTED_PARAMS = %i(affiliate_id role user_id)
  SERIALIZER_OPTIONS = {
    include: %w(affiliate user)
  }

  default_actions(%w(create show update destroy))

  def index
    affiliate_users = AffiliateUser.all.includes(:affiliate).order("affiliates.name asc")
    render json: jsonapi_index_response(
      scope: affiliate_users,
      url_method: :admin_affiliate_users_url
    )
  end
end
