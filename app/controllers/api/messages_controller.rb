class Api::MessagesController < Api::Controller
  def index
    report = Report.find(params[:report_id])
    messages = report.messages.order("created_at desc").limit(20)
    render json: messages
  end
end
