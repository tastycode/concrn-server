class Admin::DispatchesController < Admin::Controller
  MODEL = Dispatch
  default_actions

  def index
    report = Report.find(params[:filter][:report_id])
    records = report.dispatches.order("created_at")
    render json: jsonapi_index_response(
      scope: records,
      url_method: "admin_dispatches_url",
      serializer_options: {
        include: ['responder.user', 'report']
      }
    )
  end
end
