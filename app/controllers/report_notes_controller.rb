class ReportNotesController < ApplicationController
  def create
    report = Report.find(params[:data][:attributes][:report_id])
    user = authenticate_token
    if !user
      user = authenticate_user_with_twilio
      return head(:unauthorized) if !user
    end

    note = ReportNote.create(
      user: user,
      notes: report_note_params[:attributes][:notes],
      notify_reporter: report_note_params[:attributes[:notify_reporter]]
    )

    render(json: {
      data: note.attributes
    })
  end

  protected

  def report_note_params
    params.require(:data).permit(:attributes: %i(notes notify_reporter))
  end

  def authenticate_user_with_twilio
    secret_key = Secrets.twilio_access_key
    authenticated = authenticate_with_http_token do |token, options|
      if secret_key == token
        phone = PhoneNumber.normalize(report_params[:attributes][:responder_phone])
        return User.find_by(phone: phone)
      else
        return false
      end
    end
    if !authenticated
      return head :unauthorized
    end
  end
end
