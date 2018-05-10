class ReportsController < ApplicationController
  def create
    user = authenticate_token || authenticate_with_twilio || head(:unauthorized)
    report =  Report.new(report_params[:attributes])
    report.reporter = Reporter.find_or_create_by(user: user)
    report.status = "new"
    report.save

    render json: report
  end

  def index
    reports = current_user.reporter.reports.order("created_at desc")
    render json: reports
  end

  def authenticate_with_twilio
    secret_key = Rails.application.secrets.twilio[:access_key]
    authenticate_with_http_token do |token, options|
      phone = PhoneNumber.normalize(report_params[:attributes][:reporter_phone])
      secret_key == token && User.find_or_create_by(phone: phone)
    end
  end

  def report_params
    params = params.require(:data).permit(:type, {
      attributes: [:lat, :long, :address, :reporter_notes, :is_harm_immediate, :reporter_phone]
    })
  end
end
