class Admin::ReportsController < Admin::Controller
  MODEL = Report
  PERMITTED_PARAMS = %i(name phone email password)
  default_actions(%i(show update destroy))

  def index
    reports = Report.all.order("created_at desc")
    render json: jsonapi_index_response(
      scope: reports,
      url_method: :admin_users_path,
      serializer_options: {
        include: ['reporter.user']
      }
    )
  end
end
