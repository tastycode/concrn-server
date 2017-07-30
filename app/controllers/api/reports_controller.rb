class Api::ReportsController < Api::Controller
  def create
    report_params = params.require(:report).permit(:reporter_id, :lat, :long)
    report =  Report.new(report_params)
    report.status = "new"
    report.save
    render json: report
  end
end
