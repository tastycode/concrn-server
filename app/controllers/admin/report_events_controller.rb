class Admin::ReportEventsController < Admin::Controller
  MODEL = ReportEvent
  default_actions

  def index
    report = Report.find(params[:filter][:report_id])
    records = report.report_events.order("created_at")
    render json: jsonapi_index_response(
      scope: records,
      url_method: "admin_report_events_url"
    )
  end
end
