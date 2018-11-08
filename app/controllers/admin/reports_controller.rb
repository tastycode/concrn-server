class Admin::ReportsController < Admin::Controller
  MODEL = Report
  PERMITTED_PARAMS = %i(name phone email password)
  default_actions(%i(show update destroy))

  def index

    reports = if current_user.affiliate?
      # show only reports in my affiliate's zips
      Report
        .all
        .where(
          status: Report::STATUS_NEW, zip: current_user.affiliate.zip_fences.pluck(:zip))
        .or(
          Report.where(id:
            Dispatch.where(responder_id: User.find(4).affiliate.users.joins(:responder).pluck("responders.id")).pluck(:report_id)))
    else
      Report.all
    end

    render json: jsonapi_index_response(
      scope: reports.order("created_at desc"),
      url_method: :admin_users_path,
      serializer_options: {
        include: ['reporter.user']
      }
    )
  end
end
