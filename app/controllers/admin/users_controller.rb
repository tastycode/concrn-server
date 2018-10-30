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

  def index
    users = User.all.order("name")
    if params[:filter] && params[:filter][:q]
      users = users.where("name like :search", search: "%#{params[:filter][:q]}%")
    end
    if params[:filter]
      if params[:filter][:q]
      end
    end

    render json: jsonapi_index_response(
      scope: users,
      url_method: :admin_users_path
    )
  end

  def default_scope
    current_user.affiliate? ?
      current_user.affiliate.users :
      User.all
  end
end
