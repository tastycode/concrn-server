class Api::MessagesController < Api::Controller
  def index
    report = Report.find(params[:report_id])
    messages = report.messages.order("created_at desc").limit(20)
    render json: messages
  end

  def create
    report = Report.find(params[:report_id])
    report_params = params.require(:message).permit(:text)
    reporter = Reporter.find(params[:message][:reporter_id])
    message = report.messages.create(report_params.merge({
      from: reporter
    }))
    render json: message
  end
end
