class ReportsChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info("calling subscribed " + params.to_s)
    report = Report.find(params[:id])
    stream_for report
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
