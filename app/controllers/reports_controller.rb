class ReportsController < ApplicationController
  before_action :require_auth, only: %i(index)

  def create
    user = authenticate_token || authenticate_with_twilio || head(:unauthorized)
    report = Report.new(report_params[:attributes])
    report = Report::Commands::Create.perform(user: user, report: report)
    if report.valid?
      render json: report
    else
      respond_with_errors(report)
    end
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
    params.require(:data).permit(:type, {
      attributes: %i(lat long address zip reporter_notes is_harm_immediate source reporter_phone google_place_id)
    })
  end
end
