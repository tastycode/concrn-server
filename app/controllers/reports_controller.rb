class ReportsController < ApplicationController
  before_action :require_auth, only: %i(index)

  def create
    user = authenticate_token
    if !user
      user = authenticate_reporter_with_twilio
      return head(:unauthorized) if !user
    end
    report = Report.new(report_params[:attributes].except(:reporter_phone))
    report = Report::Commands::Create.perform(user: user, report: report)
    if report.valid?
      render json: report
    else
      respond_with_errors(report)
    end
  end

  def index
    Rails.logger.info("entering reportList")
    reports = current_user.reporter.reports.order("created_at desc")
    Rails.logger.info("Preparing to render report list #{reports}")
    render json: reports
  end

  def report_params
    params.require(:data).permit(:type, {
      attributes: %i(lat long address zip reporter_notes is_harm_immediate source reporter_phone google_place_id)
    })
  end

  def authenticate_reporter_with_twilio
    secret_key = Secrets.twilio_access_key
    request.headers.each { |key, value|  Rails.logger.info("auth header #{key}: #{value}") }

    @current_user ||= authenticate_with_http_token do |token, options|
      phone = PhoneNumber.normalize(report_params[:attributes][:reporter_phone])
      if secret_key == token
        result = User.find_or_create_by(phone: phone)
        return result
      else
        return false
      end
    end
  end
end
