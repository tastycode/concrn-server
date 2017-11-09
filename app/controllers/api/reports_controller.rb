class Api::ReportsController < Api::Controller
  def create
    report_params = params.require(:report).permit(:reporter_id, :lat, :long)
    report =  Report.new(report_params)
    report.status = "new"
    report.save
    render json: report
  end

  def show
  end

  def index
    reporter_id = params.require(:reporter_id)[:reporter_id]
    reports = Reporter.find(reporter_id).reports.order("created_at desc").limit(5)
    render json: reports
  end
end
