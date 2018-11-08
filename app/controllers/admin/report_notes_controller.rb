class Admin::ReportNotesController < Admin::Controller
  MODEL = ReportNote
  default_actions %i(create)
  PERMITTED_PARAMS = %i(notes report_id notify_reporter)

  def record_params
    super.merge(
      user_id: current_user.id
    )
  end
end
