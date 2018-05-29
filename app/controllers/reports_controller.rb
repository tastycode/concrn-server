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
    # TODO: Actually verify the request
    # The docs show how this works with a simple flat hash, but we have deeply nested JSON due to JSONAPI
    # https://www.twilio.com/docs/usage/security
    request_is_valid = request.headers['X-Twilio-Signature'].present? && request.headers['User-Agent'] =~ /TwilioProxy/
    if request_is_valid
      phone = PhoneNumber.normalize(report_params[:attributes][:reporter_phone])
      User.find_or_create_by(phone: phone)
    else
      head :unauthorized
    end
  end

  def report_params
    params.require(:data).permit(:type, {
      attributes: %i(lat long address zip reporter_notes is_harm_immediate source reporter_phone google_place_id)
    })
  end
end
